import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:albani/common/helpers/string_extension.dart';
import 'package:albani/common/helpers/time_formatter.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/audio/full_playlist.dart';
import 'package:albani/presentation/controllers/audio_controller.dart';
import 'package:albani/presentation/song_player/pages/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayList extends StatelessWidget {
  final int categoryId;
  final AudioController controller;

  const PlayList({
    super.key,
    required this.categoryId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final subcategories =
          controller.subcategoriesByCategory[categoryId] ?? [];
      if (subcategories.isEmpty) {
        return const Center(child: Text("No audios found"));
      }

      // Use selected or first subcategory
      final selectedId = controller.selectedSubcategoryId[categoryId];
      final sub = subcategories.firstWhere(
        (s) => s.id == selectedId,
        orElse: () => subcategories.first,
      );
      final audios = sub.audios;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Playlist',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => FullPlaylistScreen(
                        title: sub.name,
                        audios: audios,
                        author: sub.author,
                        imageUrl: sub.imageUrl,
                        playlistId: sub.id, // Pass subcategory ID
                      )),
                  child: const Text(
                    'See More',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xffC6C6C6),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: audios.length,
                itemBuilder: (context, index) {
                  final audio = audios[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => AudioPlayer(
                            playlistId: sub.id.toString(),
                            author: sub.author,
                            imageUrl: sub.imageUrl,
                            playlist: audios,
                            initialIndex: index,
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DarkMode(context).isDarkMode
                                    ? AppColors.darkGrey
                                    : const Color(0xffE6E6E6),
                              ),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: DarkMode(context).isDarkMode
                                    ? const Color(0xff959595)
                                    : const Color(0xff555555),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  audio.title.toTitleCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  sub.author,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(formatDuration(parseDuration(audio.duration))),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_outline_outlined,
                                size: 25,
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
              ),
            ),
          ),
        ],
      );
    });
  }
}
