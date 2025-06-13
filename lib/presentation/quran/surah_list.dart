import 'package:albani/presentation/controllers/quran_controller.dart';
import 'package:albani/presentation/quran/page_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurahList extends StatelessWidget {
  const SurahList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();

    return Obx(() {
      if (!controller.isReady.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final validSurahs =
          controller.surahList.where((s) => s.startPage != null).toList();

      if (validSurahs.isEmpty) {
        return const Center(child: Text("No Surahs available"));
      }

      return ListView.builder(
        itemCount: validSurahs.length,
        itemBuilder: (context, index) {
          final surah = validSurahs[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () =>
                  Get.to(() => PageViewer(startPage: surah.startPage!)),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: context.isDarkMode ? Colors.black : Colors.white,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      foregroundColor: Colors.black87,
                      child: Text(surah.number.toString()),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(surah.arabic,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('${surah.english} • ${surah.type}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ),
                    Text('p. ${surah.startPage}',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
