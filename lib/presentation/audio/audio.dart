import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/constants/audio_categories.dart';
import 'package:albani/presentation/controllers/audio_controller.dart';
import 'package:albani/presentation/home/widgets/audio_tab.dart';
import 'package:albani/presentation/home/widgets/play_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioScreen extends StatelessWidget {
  AudioScreen({super.key});
  final AudioController controller = Get.put(AudioController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: const BasicAppbar(
          title: Text(
            "Audio",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Builder(builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            controller.currentTabIndex.value = tabController.index;
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Search(),
              const SizedBox(height: 20),
              AudioTab(
                context: context,
                tabController: tabController,
                controller: controller,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  final categoryId =
                      AudioCategories.all[controller.currentTabIndex.value].id;
                  return PlayList(
                    categoryId: categoryId,
                    controller: controller,
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        height: 58,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color:
              context.isDarkMode ? Colors.grey[800] : const Color(0xffE6E6E6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.03 * 255).round()),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search audio...',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  // implement filtering here
                },
              ),
            ),
            Icon(Icons.search,
                size: 30,
                color:
                    context.isDarkMode ? Colors.grey : const Color(0xff555555)),
          ],
        ),
      ),
    );
  }
}
