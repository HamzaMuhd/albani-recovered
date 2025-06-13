import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/choose_mode/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDarkModeToggle extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  CustomDarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode(context);
      return GestureDetector(
        onTap: () {
          // Toggle between light and dark themes
          ThemeMode newThemeMode =
              isDarkMode ? ThemeMode.light : ThemeMode.dark;
          themeController.updateTheme(newThemeMode);
        },
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDarkMode ? AppColors.primary : Colors.grey,
              width: 1.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Sun Icon
              Positioned(
                left: 5,
                child: Icon(
                  Icons.wb_sunny,
                  color: isDarkMode ? Colors.grey : AppColors.primary,
                  size: 36,
                ),
              ),
              // Moon Icon
              Positioned(
                right: 5,
                child: Icon(
                  Icons.nightlight_round,
                  color: isDarkMode ? AppColors.primary : Colors.grey,
                  size: 36,
                ),
              ),
              // Switch Knob
              AnimatedAlign(
                alignment:
                    isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.primary : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
