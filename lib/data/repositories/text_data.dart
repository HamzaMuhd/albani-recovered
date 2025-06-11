import 'package:get/get.dart';

class AppStrings {
  // General Strings
  static const String title = 'title';
  static const String about = 'about';
  static const String selectLanguage = 'selectLanguage';
  static const String selectMode = 'selectMode';
  static const String getStarted = 'getStarted';
  static const String continueText = 'continueText';
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          AppStrings.title: 'Albani: Your Guide to Islamic Knowledge',
          AppStrings.about:
              'Dive into authentic Islamic teachings, explore the Quran, and stay connected with daily prayer times and Azkar. Learn and reflect with the teachings of Sheikh Albani Zaria. Start your journey toward spiritual growth today.',
          AppStrings.selectLanguage: 'Select Language',
          AppStrings.selectMode: 'Choose Mode',
          AppStrings.getStarted: 'Get Started',
          AppStrings.continueText: 'Continue',
        },
        'ha': {
          AppStrings.title: 'Albani: Jagoranka zuwa Ilimin Addinin Musulunci',
          AppStrings.about:
              "Shiga cikin koyarwar Musulunci na asali, Karanta AlQur'ani, kuma kasance tare da lokutan sallah da Azkar na yau da kullum. saurari karatuttukan Sheikh Albani Zaria. Fara tafiyarka dan ci gaban imaninka a yau.",
          AppStrings.selectLanguage: 'Zabi Yare',
          AppStrings.selectMode: 'Zabi Yanayi',
          AppStrings.getStarted: 'Fara Tafiya',
          AppStrings.continueText: 'Ci Gaba',
        },
      };
}
