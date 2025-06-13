import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/controllers/quran_controller.dart';
import 'package:albani/presentation/quran/juz_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'surah_list.dart';
import 'bookmarks_tab.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuranController());

    return Obx(() {
      if (!controller.isReady.value) {
        return Scaffold(
          body: Center(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: controller.showLinearProgress.value
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Preparing Quran...",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: controller.downloadProgress.value,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            controller.statusMessage.value,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : const CircularProgressIndicator()),
          ),
        );
      }

      return const DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: BasicAppbar(
            title: Text(
              'Quran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              tabs: [
                Tab(text: 'Surahs'),
                Tab(text: 'Juz'),
                Tab(text: 'Bookmarks'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SurahList(),
              JuzList(),
              BookmarksTab(),
            ],
          ),
        ),
      );
    });
  }
}
