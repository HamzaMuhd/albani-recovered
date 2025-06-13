import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quran_controller.dart';
import 'page_viewer.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();

    return Obx(() {
      final bookmarks = controller.bookmarks.toList()..sort();

      if (bookmarks.isEmpty) {
        return const Center(child: Text("No bookmarks yet"));
      }

      return ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (_, index) {
          final page = bookmarks[index];
          final surah = controller.getSurahByPage(page);

          return ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text(
              surah != null
                  ? "${surah.english} (${surah.arabic})"
                  : "Page $page",
            ),
            subtitle: Text("Page $page"),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => controller.toggleBookmark(page),
            ),
            onTap: () => Get.to(() => PageViewer(startPage: page)),
          );
        },
      );
    });
  }
}
