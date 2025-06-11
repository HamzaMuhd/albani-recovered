import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarController extends GetxController {
  var currentDate = DateTime.now().obs;
  var hijriDate = HijriCalendar.fromDate(DateTime.now()).obs;

  // List of Hijri months
  static const List<String> hijriMonths = [
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
    'Dhul-Hijjah',
  ];

  // List of Islamic events
  final List<Map<String, String>> islamicEvents = [
    {'hDate': '1 Ramadan', 'event': 'Start of Ramadan'},
    {'hDate': '1 Shawwal', 'event': 'Eid al-Fitr'},
    {'hDate': '10 Dhul-Hijjah', 'event': 'Eid al-Adha'},
  ];

  List<Map<String, String>> getEventsForMonth(String hMonthName) {
    return islamicEvents
        .where((event) => event['hDate']!.contains(hMonthName))
        .toList();
  }

  void updateMonth(int increment) {
    currentDate.value =
        DateTime(currentDate.value.year, currentDate.value.month + increment);
    hijriDate.value = HijriCalendar.fromDate(currentDate.value);
  }

  String formatIslamicDate(HijriCalendar hijriDate) {
    final hMonthIndex = hijriDate.hMonth - 1;
    final hMonthName = (hMonthIndex >= 0 && hMonthIndex < hijriMonths.length)
        ? hijriMonths[hMonthIndex]
        : 'Unknown';

    return '${hijriDate.hDay} $hMonthName ${hijriDate.hYear} AH';
  }
}
