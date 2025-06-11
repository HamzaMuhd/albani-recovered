import 'package:albani/core/configs/theme/app_theme.dart';
import 'package:albani/data/repositories/text_data.dart';
import 'package:albani/presentation/choose_mode/controller/theme_controller.dart';
import 'package:albani/presentation/splash/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode.value,
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: Get.locale ?? const Locale('en'),
        fallbackLocale: const Locale('en'),
        home: const SplashPage(),
      );
    });
  }
}
