import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/prayer_time/controller/prayertime_controller.dart';
import 'package:albani/presentation/prayer_time/pages/prayer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({
    super.key,
    required this.prayerController,
    required this.context,
  });

  final PrayerTimesController prayerController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 140, // Maintain the size of the vector card
        child: Stack(
          children: [
            // Background SVG
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
                fit: BoxFit.cover, // Ensure it fits perfectly
              ),
            ),
            // Content
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Obx(() {
                  return prayerController.isLocationFetched.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Prayer Information Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize
                                  .min, // Fit within available space
                              children: [
                                // Islamic Date
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      prayerController.islamicDate.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3), // Spacing
                                // Next Prayer Info
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.mosque,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.50,
                                      child: Text(
                                        'Next Prayer: ${prayerController.nextPrayerName.value}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Time: ${prayerController.nextPrayerTime.value}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                // Remaining Time
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Remaining: ${prayerController.remainingTime.value}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // "View Time" Button
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.blue,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      prayerController.locationCity.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(
                                          () => PrayerTimeScreen()); // Navigate
                                    },
                                    child: const Text(
                                      'View time',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Enable location to fetch prayer times',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Obx(() {
                              return ElevatedButton(
                                onPressed: prayerController.isFetching.value
                                    ? null
                                    : () async {
                                        await prayerController.getLocation();
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(
                                    color: AppColors.grey, // Border color
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0, // Remove shadow
                                ),
                                child: prayerController.isFetching.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Enable Location',
                                        style: TextStyle(
                                          color:
                                              Colors.white, // Pure white text
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              );
                            }),
                          ],
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
