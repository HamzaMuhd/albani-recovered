import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/controllers/calender_controller.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  final CalendarController controller = Get.put(CalendarController());

  CalendarScreen({super.key});

  DateTime hijriToGregorian(int hYear, int hMonth, int hDay) {
    final hijriCalendar = HijriCalendar()
      ..hYear = hYear
      ..hMonth = hMonth
      ..hDay = hDay;
    return hijriCalendar.hijriToGregorian(hYear, hMonth, hDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text(
          'Islamic Calendar',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => controller.updateMonth(-1),
                ),
                Obx(() {
                  final selectedDate = controller.selectedHijriDate.value;
                  final hYear = selectedDate.hYear;
                  final hMonth = selectedDate.hMonth;
                  final hDay = selectedDate.hDay;
                  final hijriMonthName =
                      CalendarController.hijriMonths[hMonth - 1];
                  final hijriDateStr = '$hDay $hijriMonthName $hYear AH';
                  final gregorianDateStr = DateFormat('d MMMM yyyy')
                      .format(hijriToGregorian(hYear, hMonth, hDay));

                  return Column(
                    children: [
                      Text(
                        hijriDateStr,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        gregorianDateStr,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  );
                }),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => controller.updateMonth(1),
                ),
              ],
            ),
          ),
          Obx(() {
            final hijriMonth = controller.hijriDate.value.hMonth;
            final hijriYear = controller.hijriDate.value.hYear;
            final hijriCalendar = HijriCalendar()
              ..hYear = hijriYear
              ..hMonth = hijriMonth;
            final daysInMonth =
                hijriCalendar.getDaysInMonth(hijriYear, hijriMonth);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 0.9,
              ),
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                final hijriDay = index + 1;
                final date = HijriCalendar()
                  ..hYear = hijriYear
                  ..hMonth = hijriMonth
                  ..hDay = hijriDay;

                final hMonthName =
                    CalendarController.hijriMonths[hijriMonth - 1];
                final hDateStr = '$hijriDay $hMonthName';

                final isToday = controller.isTodayHijri(date);
                final isSelected = controller.selectedHijriDate.value.hDay ==
                        date.hDay &&
                    controller.selectedHijriDate.value.hMonth == date.hMonth &&
                    controller.selectedHijriDate.value.hYear == date.hYear;
                final isEvent = controller
                    .getAllEvents()
                    .any((event) => event['hDate'] == hDateStr);

                return GestureDetector(
                  onTap: () => controller.selectDate(date),
                  child: Card(
                    color: isSelected
                        ? Colors.blueAccent.withOpacity(0.7)
                        : isEvent
                            ? Colors.amberAccent.withOpacity(0.6)
                            : (isToday ? AppColors.primary : Colors.white),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$hijriDay",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                        if (isEvent)
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child:
                                Icon(Icons.star, size: 16, color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          Builder(
            builder: (_) {
              final events = controller.getAllEvents();
              if (events.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No events available."),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final parts = event['hDate']?.split(' ');
                  final hDay = int.tryParse(parts?[0] ?? '');
                  final hMonth =
                      CalendarController.hijriMonths.indexOf(parts?[1] ?? '') +
                          1;
                  final hYear = controller.hijriDate.value.hYear;
                  final gDateStr = DateFormat('d MMMM yyyy')
                      .format(hijriToGregorian(hYear, hMonth, hDay ?? 1));

                  return Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.symmetric(vertical: 2.0),
                    child: ListTile(
                      leading:
                          const Icon(Icons.event, color: AppColors.primary),
                      title: Text(event['event'] ?? ""),
                      subtitle: Text("${event['hDate']} - $gDateStr"),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
