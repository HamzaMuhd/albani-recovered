import 'package:albani/data/models/subcategories_model.dart';
import 'package:get/get.dart';
import 'package:albani/main.dart';

class AudioPlayerController extends GetxController {
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final RxBool isPlaying = false.obs;
  final RxInt currentIndex = 0.obs;
  final Rx<Audio?> currentAudio = Rx<Audio?>(null);

  List<Audio> playlist = [];

  void loadPlaylist({
    required List<Audio> audios,
    required int startIndex,
    required String author,
    required String imageUrl,
  }) {
    playlist = audios;
    currentIndex.value = startIndex;
    currentAudio.value = audios[startIndex];
    audioHandler.playAudios(audios, startIndex,
        author: author, imageUrl: imageUrl);
  }

  @override
  void onInit() {
    super.onInit();

    audioHandler.playbackState.listen((state) {
      isPlaying.value = state.playing;
      position.value = state.updatePosition;
    });

    audioHandler.mediaItem.listen((item) {
      if (item != null) {
        final index = playlist.indexWhere((audio) => audio.url == item.id);
        if (index != -1) {
          currentIndex.value = index;
          currentAudio.value = playlist[index];
        }
      }
    });

    audioHandler.durationStream.listen((d) {
      duration.value = d;
    });
  }

  void togglePlayPause() {
    isPlaying.value ? audioHandler.pause() : audioHandler.play();
  }

  void nextAudio() {
    if (currentIndex.value < playlist.length - 1) {
      currentIndex.value++;
      currentAudio.value = playlist[currentIndex.value];
      audioHandler.skipToQueueItem(currentIndex.value);
    }
  }

  void previousAudio() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      currentAudio.value = playlist[currentIndex.value];
      audioHandler.skipToQueueItem(currentIndex.value);
    }
  }

  void stopAudio() => audioHandler.stop();

  void seek(Duration pos) => audioHandler.seek(pos);
}
