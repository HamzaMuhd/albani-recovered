import 'package:albani/common/helpers/string_extension.dart';
import 'package:albani/common/helpers/time_formatter.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/data/models/subcategories_model.dart';
import 'package:albani/presentation/song_player/pages/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullPlaylistScreen extends StatelessWidget {
  final String title;
  final String author;
  final List audios;
  final String imageUrl;

  const FullPlaylistScreen({
    super.key,
    required this.title,
    required this.audios,
    required this.author,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        foregroundColor: context.isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: audios.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final audio = audios[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => AudioPlayer(
                    author: author,
                    imageUrl: imageUrl,
                    playlist: audios.cast<Audio>(),
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
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          audio.title.toString().toTitleCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          author,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(formatDuration(parseDuration(audio.duration))),
              ],
            ),
          );
        },
      ),
    );
  }
}
