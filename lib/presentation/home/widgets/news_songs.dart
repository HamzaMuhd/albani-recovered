import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/controllers/audio_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsSongs extends StatelessWidget {
  final int categoryId;
  final AudioController controller = Get.put(AudioController());

  NewsSongs({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.subcategoriesByCategory.containsKey(categoryId) &&
          !controller.loadingCategories.contains(categoryId)) {
        controller.loadSubcategories(categoryId);
      }
    });

    return Obx(() {
      final isLoading = controller.loadingCategories.contains(categoryId);
      final subcategories = controller.subcategoriesByCategory[categoryId];
      final isOffline = controller.noInternet.value;
      final isFailed = controller.failedCategoryIds.contains(categoryId);

      if (isLoading || subcategories == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (subcategories.isEmpty) {
        if (isOffline || isFailed) {
          return const Center(
              child: Text('No internet connection. Please retry.'));
        }
        return const Center(child: Text('No audios available'));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: subcategories.length,
            itemBuilder: (context, index) {
              final sub = subcategories[index];

              return GestureDetector(
                onTap: () {
                  controller.selectSubcategory(categoryId, sub.id);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => const SongPlayer(),
                  //   ),
                  // );
                },
                child: SizedBox(
                  width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: sub.imageUrl,
                          imageBuilder: (context, imageProvider) => Container(
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
                                transform: Matrix4.translationValues(10, 10, 0),
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
                              child: CircularProgressIndicator(strokeWidth: 2),
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
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 14),
          ),
        ),
      );
    });
  }
}
