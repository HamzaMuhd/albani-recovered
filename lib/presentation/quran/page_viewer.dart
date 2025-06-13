import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/controllers/quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewer extends StatelessWidget {
  final int startPage;
  const PageViewer({super.key, required this.startPage});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();
    controller.currentPage.value = startPage;

    final pageController = PageController(
      initialPage: startPage - 1,
    );

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final page = controller.currentPage.value;
          final surah = controller.getSurahByPage(page);
          return Text(surah != null ? surah.english : "");
        }),
        actions: [
          Obx(() {
            final page = controller.currentPage.value;
            final isMarked = controller.bookmarks.contains(page);
            return IconButton(
              icon: Icon(isMarked ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () => controller.toggleBookmark(page),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              reverse: true,
              itemCount: 604,
              onPageChanged: (i) => controller.currentPage.value = i + 1,
              itemBuilder: (_, index) {
                final file = controller.getPageFile(index + 1);
                return file.existsSync()
                    ? Image.file(
                        file,
                        fit: BoxFit.contain,
                        color: context.isDarkMode ? AppColors.grey : null,
                      )
                    : const Center(child: Text("Image not found"));
              },
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "${controller.currentPage.value}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              )),
        ],
      ),
    );
  }
}
