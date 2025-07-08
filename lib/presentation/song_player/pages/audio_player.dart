import 'package:albani/common/helpers/time_formatter.dart';
import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/data/models/subcategories_model.dart';
import 'package:albani/presentation/controllers/audio_player_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayer extends StatelessWidget {
  final String author;
  final String imageUrl;
  final List<Audio> playlist;
  final int initialIndex;

  const AudioPlayer({
    super.key,
    required this.author,
    required this.imageUrl,
    required this.playlist,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AudioPlayerController());
    controller.loadPlaylist(
        audios: playlist,
        startIndex: initialIndex,
        author: author,
        imageUrl: imageUrl);

    return Scaffold(
      appBar: BasicAppbar(
        title: const Text('Now Playing'),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            _AudioCover(imageUrl),
            const SizedBox(height: 20),
            Obx(() {
              final audio = controller.currentAudio.value;
              return _AudioDetail(
                title: audio?.title ?? '',
                author: author,
              );
            }),
            const SizedBox(height: 30),
            _AudioPlayer(controller),
          ],
        ),
      ),
    );
  }

  static Widget _AudioCover(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 240,
        width: 240,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 240,
          width: 240,
          color: AppColors.darkGrey,
          child: const Icon(Icons.music_note, size: 100, color: Colors.white),
        ),
        errorWidget: (context, url, error) => Container(
          height: 240,
          width: 240,
          color: AppColors.darkGrey,
          child: const Icon(Icons.broken_image, size: 100, color: Colors.white),
        ),
      ),
    );
  }

  static Widget _AudioDetail({required String title, required String author}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          author,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  static Widget _AudioPlayer(AudioPlayerController controller) {
    return Obx(() {
      final duration = controller.duration.value;
      final position = controller.position.value;

      return Column(
        children: [
          Slider(
            value: position.inSeconds
                .toDouble()
                .clamp(0, duration.inSeconds.toDouble()),
            max: duration.inSeconds.toDouble(),
            onChanged: (value) {
              controller.seek(Duration(seconds: value.toInt()));
            },
            activeColor: AppColors.primary,
            inactiveColor: Colors.grey[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatDuration(position),
                  style: const TextStyle(fontSize: 12)),
              Text(formatDuration(duration),
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: controller.previousAudio,
                icon: const Icon(Icons.skip_previous_rounded, size: 48),
              ),
              IconButton(
                onPressed: controller.togglePlayPause,
                icon: Icon(
                  controller.isPlaying.value
                      ? Icons.pause_circle
                      : Icons.play_circle,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                onPressed: controller.nextAudio,
                icon: const Icon(Icons.skip_next_rounded, size: 48),
              ),
            ],
          ),
        ],
      );
    });
  }
}
