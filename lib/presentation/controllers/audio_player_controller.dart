import 'package:albani/data/models/subcategories_model.dart';
import 'package:get/get.dart';
import 'package:albani/main.dart'; // access audioHandler

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

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
    isPlaying.value ? audioHandler.play() : audioHandler.pause();
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
