import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/prayer_time/controller/prayertime_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrayerTimeScreen extends StatelessWidget {
  final PrayerTimesController _controller = Get.put(PrayerTimesController());

  PrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text(
          'Prayer Times',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (_controller.isFetching.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!_controller.isLocationFetched.value) {
          return Center(
            child: ElevatedButton(
              onPressed: _controller.getLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Fetch Location'),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Islamic Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _controller.islamicDate.value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 26.0,
                        color: AppColors.primary,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${_controller.locationCity}, ${_controller.location}', // Display the location next to the date
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // Make it stand out with a different color if needed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Current Time
              Obx(() => Text(
                    'Current Time: ${DateFormat.jm().format(_controller.currentTime.value)}',
                    style: const TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 20),
              // Next Prayer
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next Prayer: ${_controller.nextPrayerName.value}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Time: ${_controller.nextPrayerTime.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Remaining: ${_controller.remainingTime.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Prayer Times List
              const Text(
                'Prayer Times',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              prayerTimeCard(
                'Fajr',
                _controller.prayerTimes.value?.fajr,
                additionalLabel: 'Sunrise',
                additionalTime: _controller.sunriseTime.value,
              ),
              prayerTimeCard('Dhuhr', _controller.prayerTimes.value?.dhuhr),
              prayerTimeCard('Asr', _controller.prayerTimes.value?.asr),
              prayerTimeCard('Maghrib', _controller.prayerTimes.value?.maghrib),
              prayerTimeCard('Isha', _controller.prayerTimes.value?.isha,
                  additionalLabel: 'Last Third of Night',
                  additionalTime: _controller.lastThirdOfNightStart.value),
            ],
          ),
        );
      }),
    );
  }

  Widget prayerTimeCard(String prayerName, DateTime? time,
      {String? additionalLabel, String? additionalTime}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(
          Icons.access_time,
          color: AppColors.primary,
        ),
        title: Text(
          prayerName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: additionalLabel != null && additionalTime != null
            ? Text(
                '$additionalLabel: $additionalTime',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              )
            : null,
        trailing: Text(
          time != null ? DateFormat.jm().format(time) : 'N/A',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
