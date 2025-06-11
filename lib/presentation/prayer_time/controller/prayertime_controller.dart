import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class PrayerTimesController extends GetxController {
  var prayerTimes = Rxn<PrayerTimes>();
  var currentTime = DateTime.now().obs;
  var islamicDate = ''.obs;
  late Timer _timer;
  var nextPrayerTime = ''.obs;
  var nextPrayerName = ''.obs;
  var remainingTime = ''.obs;
  var location = ''.obs;
  var locationCity = ''.obs;
  var sunriseTime = ''.obs;
  var lastThirdOfNightStart = ''.obs;
  var isLocationFetched = false.obs;
  var isFetching = false.obs;
  final _storage = GetStorage();

  static void showSuccess({
    required String message,
  }) {
    Get.snackbar(
      "Success 🎉",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 5),
    );
  }

  static void showError({
    required String errorMessage,
  }) {
    Get.snackbar(
      "Error 😞",
      errorMessage,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _getSavedLocation();
    loadSavedLocationName();
  }

  @override
  void onClose() {
    super.onClose();
    // Ensure timer is canceled only if it's active
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  // Fetch user's current location with error handling
  Future<void> getLocation() async {
    try {
      isFetching.value = true;
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw 'Please enable location services.';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw 'Location permission is denied';
        }
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _saveLocation(position.latitude, position.longitude); // Save location
      await getLocationName(position.latitude, position.longitude);
      updatePrayerTimes(position.latitude, position.longitude);

      showSuccess(
          message: 'Location fetched and prayer times updated successfully.');
    } catch (e) {
      final errorMessage =
          e is String ? e : 'An unexpected error occurred. Please try again.';
      showError(errorMessage: errorMessage);
      return Future.error(errorMessage);
    } finally {
      isFetching.value = false; // Set fetching to false when the process ends
    }
  }

  Future<void> getLocationName(double latitude, double longitude) async {
    try {
      // Use geocoding to get the location
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        location.value = '${placemarks[0].country}';
        locationCity.value = '${placemarks[0].locality}';
        _storage.write('locationDetails', {
          'country': location.value,
          'locality': locationCity.value,
        });
      }
    } catch (e) {
      print('Error fetching location name: $e');
      location.value = 'Unknown';
      locationCity.value = 'Unknown';
    }
  }

  // Save the location after fetching it
  void _saveLocation(double latitude, double longitude) {
    _storage.write('latitude', latitude);
    _storage.write('longitude', longitude);
  }

  // Get saved location and update prayer times
  Future<void> _getSavedLocation() async {
    double? latitude = _storage.read('latitude');
    double? longitude = _storage.read('longitude');
    if (latitude != null && longitude != null) {
      updatePrayerTimes(latitude, longitude);
    } else {
      // Do not automatically fetch the location here.
      isLocationFetched.value = false; // Allow UI to handle location request.
    }
  }

  void loadSavedLocationName() {
    Map<String, dynamic>? locationDetails = _storage.read('locationDetails');
    if (locationDetails != null) {
      location.value = locationDetails['country'] ?? '';
      locationCity.value = locationDetails['locality'] ?? '';
    }
  }

  // Update the Islamic date
  void updateIslamicDate() {
    final hijriDate = HijriCalendar.fromDate(DateTime.now());
    islamicDate.value = formatIslamicDate(hijriDate);
  }

  // Format the Islamic date
  String formatIslamicDate(HijriCalendar hijriDate) {
    const hijriMonths = [
      'Muharram',
      'Safar',
      'Rabi\' al-Awwal',
      'Rabi\' al-Thani',
      'Jumada I',
      'Jumada II',
      'Rajab',
      'Sha\'ban',
      'Ramadan',
      'Shawwal',
      'Dhul-Qi\'dah',
      'Dhul-Hijjah'
    ];

    // Handle edge cases for hijriMonth
    if (hijriDate.hMonth < 1 || hijriDate.hMonth > 12) {
      return 'Invalid Month';
    }

    return '${hijriDate.hDay} ${hijriMonths[hijriDate.hMonth - 1]} ${hijriDate.hYear} AH';
  }

  void updatePrayerTimes(double latitude, double longitude) {
    final coordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.muslim_world_league.getParameters();
    prayerTimes.value = PrayerTimes.today(coordinates, params);
    if (prayerTimes.value != null) {
      updateIslamicDate();
      calculateNextPrayerTime();
      calculateSunriseAndLastThirdOfNight();
    } else {
      nextPrayerTime.value = 'Unable to fetch prayer times';
    }

    startTimer();

    isLocationFetched.value = true;
  }

  // Calculate the next prayer time and remaining time
  void calculateNextPrayerTime() {
    final now = DateTime.now();
    final upcomingTimes = [
      {'name': 'Fajr', 'time': prayerTimes.value!.fajr},
      {'name': 'Dhuhr', 'time': prayerTimes.value!.dhuhr},
      {'name': 'Asr', 'time': prayerTimes.value!.asr},
      {'name': 'Maghrib', 'time': prayerTimes.value!.maghrib},
      {'name': 'Isha', 'time': prayerTimes.value!.isha}
    ];
    bool isNextPrayerFound = false;

    for (var prayer in upcomingTimes) {
      final prayerTime = prayer['time'] as DateTime;
      if (prayerTime.isAfter(now)) {
        // Set the next prayer name and time
        nextPrayerName.value = prayer['name'] as String;
        nextPrayerTime.value = DateFormat.jm().format(prayerTime);

        // Calculate the remaining time until the next prayer
        final difference = prayerTime.difference(now);
        remainingTime.value =
            '${difference.inHours}h ${difference.inMinutes % 60}m ${difference.inSeconds % 60}s';
        isNextPrayerFound = true;
        break;
      }
    }
    if (!isNextPrayerFound) {
      final tomorrow = now.add(const Duration(days: 1));
      final tomorrowDateComponents =
          DateComponents(tomorrow.year, tomorrow.month, tomorrow.day);
      final coordinates = Coordinates(prayerTimes.value!.coordinates.latitude,
          prayerTimes.value!.coordinates.longitude);
      final params = CalculationMethod.muslim_world_league.getParameters();
      final tomorrowPrayerTimes =
          PrayerTimes(coordinates, tomorrowDateComponents, params);

      nextPrayerName.value = 'Fajr';
      nextPrayerTime.value = DateFormat.jm().format(tomorrowPrayerTimes.fajr);

      // Calculate the remaining time until Fajr
      final difference = tomorrowPrayerTimes.fajr.difference(now);
      remainingTime.value =
          '${difference.inHours}h ${difference.inMinutes % 60}m ${difference.inSeconds % 60}s';
    }
  }

  void calculateSunriseAndLastThirdOfNight() {
    if (prayerTimes.value == null) return;

    // Update Sunrise Time
    final sunrise = prayerTimes.value!.sunrise;
    sunriseTime.value = DateFormat.jm().format(sunrise);

    // Calculate Last Third of the Night
    final maghrib = prayerTimes.value!.maghrib;
    final fajr = prayerTimes.value!.fajr;

    // If Fajr is earlier in the day (e.g., past midnight)
    final adjustedFajr =
        fajr.isBefore(maghrib) ? fajr.add(const Duration(days: 1)) : fajr;

    final nightDuration = adjustedFajr.difference(maghrib);
    final lastThirdDuration = Duration(seconds: nightDuration.inSeconds ~/ 3);
    final lastThirdStart = adjustedFajr.subtract(lastThirdDuration);

    lastThirdOfNightStart.value = DateFormat.jm().format(lastThirdStart);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = DateTime.now();
      calculateNextPrayerTime();
    });
  }
}
