import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/presentation/home/pages/home.dart';
import 'package:albani/presentation/prayer_time/pages/prayer_screen.dart';
import 'package:albani/presentation/profile_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final destinations = [
    const Destination(
      icon: Icons.home,
      label: 'Home',
    ),
    const Destination(
      isSvg: true,
      icon: Icons.mosque,
      selectedSvg: AppVectors.mosque,
      unselectedSvg: AppVectors.mosque,
      label: 'Prayer Time',
    ),
    const Destination(
      icon: Icons.play_circle_fill,
      label: 'Audio',
    ),
    const Destination(
      isSvg: true,
      label: 'Quran',
      selectedSvg: AppVectors.quranClosed,
      unselectedSvg: AppVectors.quranOpen,
    ),
    const Destination(
      icon: Icons.person,
      label: 'Profile',
    ),
  ];

  final screens = [
    const HomePage(),
    PrayerTimeScreen(),
    const HomePage(),
    const HomePage(),
    ProfilePage(),
  ];
}

class Destination {
  final IconData? icon;
  final String label;
  final String? selectedSvg; // Optional image for selected state
  final String? unselectedSvg; // Optional image for unselected state
  final bool isSvg;

  const Destination({
    this.icon,
    required this.label,
    this.selectedSvg,
    this.unselectedSvg,
    this.isSvg = false,
  });
}
