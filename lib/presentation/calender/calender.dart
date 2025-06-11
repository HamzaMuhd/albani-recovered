import 'package:albani/presentation/controllers/calender_controller.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  final CalendarController controller = Get.put(CalendarController());

  CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Islamic Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Month Navigation (Hijri only)
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
                  final hijriMonthName = CalendarController
                      .hijriMonths[controller.hijriDate.value.hMonth - 1];
                  return Text(
                    "$hijriMonthName ${controller.hijriDate.value.hYear} AH",
                    style: const TextStyle(fontSize: 20),
                  );
                }),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => controller.updateMonth(1),
                ),
              ],
            ),
          ),

          // Calendar Grid (Hijri Calendar Only)
          Expanded(
            flex: 2,
            child: Obx(() {
              final hijriMonthName = CalendarController
                  .hijriMonths[controller.hijriDate.value.hMonth - 1];
              final hijriCalendar = HijriCalendar.fromDate(DateTime.now());

              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: hijriCalendar.getDaysInMonth(hijriCalendar.hYear,
                    hijriCalendar.hMonth), // Corrected here
                itemBuilder: (context, index) {
                  final hijriDay = index + 1; // Adjust day
                  final hijriMonth = hijriCalendar.hMonth;
                  final hijriYear = hijriCalendar.hYear;
                  final hijriWeekDayName =
                      hijriCalendar.weekDay(); // Correct method

                  var events = controller.getEventsForMonth(
                      hijriMonthName); // Get events for this month
                  final isEvent = events.any(
                      (event) => event['hDate'] == '$hijriDay $hijriMonthName');

                  final isToday = DateTime.now().day == hijriDay &&
                      DateTime.now().month == hijriMonth &&
                      DateTime.now().year == hijriYear;

                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      color: isEvent
                          ? Colors.amberAccent.withOpacity(0.6)
                          : (isToday
                              ? Colors.teal.withOpacity(0.8)
                              : Colors.white),
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
                          Text(
                            "$hijriDay $hijriWeekDayName",
                            style: TextStyle(
                              fontSize: 12,
                              color: isToday ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          if (isEvent)
                            const Icon(Icons.star, size: 16, color: Colors.red),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Always show events below the calendar
          Obx(() {
            final events = controller.getEventsForMonth(CalendarController
                .hijriMonths[controller.hijriDate.value.hMonth - 1]);
            if (events.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No events available."),
              );
            }

            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: const Icon(Icons.event, color: Colors.teal),
                      title: Text(event['event'] ?? ""),
                      subtitle: Text(event['hDate'] ?? ""),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
