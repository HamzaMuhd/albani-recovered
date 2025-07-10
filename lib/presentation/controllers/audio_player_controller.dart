import 'package:albani/data/models/subcategories_model.dart';
import 'package:get/get.dart';
import 'package:albani/presentation/controllers/audio_handler.dart';

class AudioPlayerController extends GetxController {
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final RxBool isPlaying = false.obs;
  final RxInt currentIndex = 0.obs;
  final Rx<Audio?> currentAudio = Rx<Audio?>(null);

  List<Audio> playlist = [];
  final AudioPlayerService playerService = AudioPlayerService();

  Future<void> loadPlaylist({
    required List<Audio> audios,
    required int startIndex,
    required String author,
    required String imageUrl,
  }) async {
    playlist = audios;
    currentIndex.value = startIndex;
    currentAudio.value = audios[startIndex];

    try {
      await playerService.playAudios(audios, startIndex,
          author: author, imageUrl: imageUrl);
    } catch (e) {
      print("Audio play error: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();

    playerService.player.positionStream.distinct().listen((pos) {
      position.value = pos;
    });

    playerService.player.durationStream.distinct().listen((dur) {
      if (dur != null) duration.value = dur;
    });

    playerService.player.playingStream.distinct().listen((playing) {
      isPlaying.value = playing;
    });
  }

  void togglePlayPause() => playerService.togglePlayPause();

  void nextAudio() {
    if (currentIndex.value < playlist.length - 1) {
      _jumpTo(currentIndex.value + 1);
    }
  }

  void previousAudio() {
    if (currentIndex.value > 0) {
      _jumpTo(currentIndex.value - 1);
    }
  }

  void stopAudio() => playerService.stop();

  void seek(Duration pos) => playerService.seek(pos);

  void _jumpTo(int index) {
    currentIndex.value = index;
    currentAudio.value = playlist[index];
    playerService.skipToIndex(index);
  }
}
