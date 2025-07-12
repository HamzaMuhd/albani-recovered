import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/constants/audio_categories.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/audio/full_playlist.dart';
import 'package:albani/presentation/controllers/audio_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioScreen extends StatelessWidget {
  final AudioController controller = Get.put(AudioController());

  AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AudioCategories.all.length,
      child: Scaffold(
        appBar: const BasicAppbar(
          title: Text(
            "Audio",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SearchBar(controller: controller),
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelColor: context.isDarkMode ? Colors.white : Colors.black,
              indicatorColor: AppColors.primary,
              tabs: AudioCategories.all.map((c) => Tab(text: c.name)).toList(),
              onTap: (index) => controller
                  .onCategoryTabChanged(AudioCategories.all[index].id),
            ),
            Expanded(
              child: Obx(() {
                final isSearching = controller.searchQuery.isNotEmpty;
                final subcategories = isSearching
                    ? controller.filteredSubcategories
                    : controller.getSubcategoriesForSelectedTab();

                final isLoading = controller.isLoading.value ||
                    controller.loadingCategories
                        .contains(controller.selectedCategoryId.value);
                final isOffline = controller.noInternet.value;
                final isFailed = controller.failedCategoryIds
                    .contains(controller.selectedCategoryId.value);

                if (isSearching && controller.searchQuery.value.length < 3) {
                  return const Center(
                      child: Text('Type at least 3 characters to search.'));
                }

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (subcategories.isEmpty) {
                  if (isOffline || isFailed) {
                    return const Center(
                        child: Text('No internet connection. Please retry.'));
                  }
                  return const Center(child: Text("No audios available"));
                }

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: GridView.builder(
                    itemCount: subcategories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final sub = subcategories[index];

                      return GestureDetector(
                        onTap: () => Get.to(() => FullPlaylistScreen(
                              title: sub.name,
                              audios: sub.audios,
                              author: sub.author,
                              imageUrl: sub.imageUrl,
                              playlistId: sub.id, // Pass subcategory ID
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: sub.imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      transform:
                                          Matrix4.translationValues(10, 10, 0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.isDarkMode
                                            ? AppColors.darkGrey
                                            : const Color(0xffE6E6E6),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        color: context.isDarkMode
                                            ? const Color(0xff959595)
                                            : const Color(0xff555555),
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              sub.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              sub.author,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final AudioController controller;
  const SearchBar({super.key, required this.controller});

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
                onChanged: controller.onSearchChanged,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search topics or authors...',
                  hintStyle: TextStyle(fontSize: 14),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: 30,
              color: context.isDarkMode ? Colors.grey : const Color(0xff555555),
            ),
          ],
        ),
      ),
    );
  }
}
