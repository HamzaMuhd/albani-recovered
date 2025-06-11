import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarController extends GetxController {
  var currentDate = DateTime.now().obs;
  var hijriDate = HijriCalendar.fromDate(DateTime.now()).obs;
  var selectedHijriDate = HijriCalendar.fromDate(DateTime.now()).obs;

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

  final List<Map<String, String>> islamicEvents = [
    {'hDate': '1 Ramadan', 'event': 'Start of Ramadan'},
    {'hDate': '1 Shawwal', 'event': 'Eid al-Fitr'},
    {'hDate': '10 Dhul-Hijjah', 'event': 'Eid al-Adha'},
  ];

  List<Map<String, String>> getAllEvents() => islamicEvents;

  void updateMonth(int increment) {
    currentDate.value =
        DateTime(currentDate.value.year, currentDate.value.month + increment);
    hijriDate.value = HijriCalendar.fromDate(currentDate.value);
    selectedHijriDate.value = HijriCalendar()
      ..hYear = hijriDate.value.hYear
      ..hMonth = hijriDate.value.hMonth
      ..hDay = 1;
  }

  void selectDate(HijriCalendar date) {
    selectedHijriDate.value = date;
  }

  bool isTodayHijri(HijriCalendar date) {
    final todayHijri = HijriCalendar.fromDate(DateTime.now());
    return date.hDay == todayHijri.hDay &&
        date.hMonth == todayHijri.hMonth &&
        date.hYear == todayHijri.hYear;
  }
}
