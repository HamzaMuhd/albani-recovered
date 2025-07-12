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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                indicator: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                indicatorSize: TabBarIndicatorSize.tab, // cover full tab
                labelColor: AppColors.primary,
                unselectedLabelColor:
                    context.isDarkMode ? Colors.white70 : Colors.black87,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                tabs:
                    AudioCategories.all.map((c) => Tab(text: c.name)).toList(),
                onTap: (index) => controller
                    .onCategoryTabChanged(AudioCategories.all[index].id),
              ),
            ),
            Expanded(
              child: Obx(() {
                final isSearching = controller.searchQuery.isNotEmpty;
                final selectedCategory = controller.selectedCategoryId.value;

                final isLoading = controller.isLoading.value ||
                    controller.loadingCategories.contains(selectedCategory);
                final isOffline = controller.noInternet.value;
                final isFailed =
                    controller.failedCategoryIds.contains(selectedCategory);

                final subcategories = isSearching
                    ? controller.filteredSubcategories
                    : controller.subcategoriesByCategory[selectedCategory];

                if (isSearching && controller.searchQuery.value.length < 3) {
                  return const Center(
                      child: Text('Type at least 3 characters to search.'));
                }

                if (isLoading || subcategories == null) {
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
                              playlistId: sub.id,
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? Colors.grey[900]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: CachedNetworkImage(
                                          imageUrl: sub.imageUrl,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                                child:
                                                    Icon(Icons.broken_image)),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 8,
                                      //   right: 8,
                                      //   child: CircleAvatar(
                                      //     backgroundColor:
                                      //         Colors.white.withOpacity(0.85),
                                      //     child: const Icon(Icons.play_arrow,
                                      //         color: AppColors.primary),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sub.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        sub.author,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color:
              context.isDarkMode ? Colors.grey[800] : const Color(0xffE6E6E6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 5,
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
                  focusedBorder: InputBorder.none, // removes focus glow
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: 26,
              color: context.isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
