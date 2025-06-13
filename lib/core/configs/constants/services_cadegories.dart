import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/presentation/audio/audio.dart';
import 'package:albani/presentation/azkar/azkar.dart';
import 'package:albani/presentation/calender/calender.dart';
import 'package:albani/presentation/prayer_time/pages/prayer_screen.dart';
import 'package:albani/presentation/quran/quran.dart';
import 'package:get/get.dart';

class CategoriesData {
  static final List<Category> categories = [
    Category(
      title: 'Azkar',
      image: AppVectors.prayer,
      onTap: () => Get.to(() => const AzkarScreen()),
    ),
    Category(
      title: 'Prayer Time',
      image: AppVectors.mosque,
      onTap: () => Get.to(() => PrayerTimeScreen()),
    ),
    Category(
      title: 'Calender',
      image: AppVectors.calender,
      onTap: () => Get.to(() => CalendarScreen()),
    ),
    Category(
      title: 'Quran',
      image: AppVectors.quranOpen,
      onTap: () => Get.to(() => const QuranScreen()),
    ),
    Category(
      title: 'Audio',
      image: AppVectors.audio,
      onTap: () => Get.to(() => const AudioScreen()),
    ),
  ];
}

class Category {
  final String title;
  final String image;
  final void Function() onTap;

  Category({
    required this.title,
    required this.image,
    required this.onTap,
  });
}
