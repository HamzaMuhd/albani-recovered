import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage(); // Persistent storage

  // Reactive variable for theme state
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme from storage or default to system theme
    final savedThemeIndex = _storage.read('theme') ?? ThemeMode.system.index;
    themeMode.value = ThemeMode.values[savedThemeIndex];
  }

  void updateTheme(ThemeMode newThemeMode) {
    themeMode.value = newThemeMode;
    _storage.write('theme', newThemeMode.index); // Save state persistently
  }

  bool isDarkMode(BuildContext context) {
    if (themeMode.value == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return themeMode.value == ThemeMode.dark;
  }
}
