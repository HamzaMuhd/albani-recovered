import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxString selectedLanguage = 'en'.obs;

  void selectLanguage(String langCode) {
    selectedLanguage.value = langCode;
    Get.updateLocale(Locale(langCode));
  }
}
