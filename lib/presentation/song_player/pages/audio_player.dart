import 'package:albani/common/helpers/time_formatter.dart';
import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/data/models/subcategories_model.dart';
import 'package:albani/presentation/controllers/audio_player_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayer extends StatefulWidget {
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
  State<AudioPlayer> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayer> {
  final controller = Get.find<AudioPlayerController>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      controller.loadPlaylist(
        audios: widget.playlist,
        startIndex: widget.initialIndex,
        author: widget.author,
        imageUrl: widget.imageUrl,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text('Now Playing'),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _AudioCover(widget.imageUrl),
            const SizedBox(height: 20),
            Obx(() {
              final audio = controller.currentAudio.value;

              if (audio == null) {
                return const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return _AudioDetail(
                title: audio.title,
                author: widget.author,
              );
            }),
            const SizedBox(height: 30),
            _AudioPlayer(controller),
          ],
        ),
      ),
    );
  }

  static Widget _AudioCover(String imageUrl) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 240,
          width: 240,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppColors.darkGrey,
            child: const Icon(Icons.music_note, size: 100, color: Colors.white),
          ),
          errorWidget: (context, url, error) => Container(
            color: AppColors.darkGrey,
            child:
                const Icon(Icons.broken_image, size: 100, color: Colors.white),
          ),
        ),
      );

  static Widget _AudioDetail({required String title, required String author}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(author,
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      );

  Widget _AudioPlayer(AudioPlayerController controller) {
    return Obx(() {
      final duration = controller.duration.value;
      final position = controller.position.value;

      return Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: position.inMilliseconds
                  .clamp(0, duration.inMilliseconds)
                  .toDouble(),
              max: duration.inMilliseconds.toDouble(),
              onChanged: (value) =>
                  controller.seek(Duration(milliseconds: value.toInt())),
              activeColor: AppColors.primary,
              inactiveColor: Colors.grey[400],
            ),
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
