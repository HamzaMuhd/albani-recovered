import 'package:albani/data/models/subcategories_model.dart';
import 'package:get/get.dart';
import 'package:albani/presentation/controllers/audio_handler.dart';
import 'package:get_storage/get_storage.dart';

class AudioPlayerController extends GetxController {
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final RxBool isPlaying = false.obs;
  final RxInt currentIndex = 0.obs;
  final Rx<Audio?> currentAudio = Rx<Audio?>(null);
  final RxString currentPlaylistId = ''.obs;

  List<Audio> playlist = [];
  final AudioPlayerService playerService = AudioPlayerService();
  final GetStorage storage = GetStorage();

  static const _prefsPlaylistId = 'resume_playlist_id';
  static const _prefsAudioIndex = 'resume_audio_index';
  static const _prefsAudioUrl = 'resume_audio_url';
  static const _prefsAudioPositions = 'audio_positions';
  static const _prefsIsPlaying = 'resume_is_playing';

  @override
  void onInit() {
    super.onInit();
    _initPlayerListeners();
  }

  void _initPlayerListeners() {
    playerService.player.positionStream.distinct().listen((pos) {
      position.value = pos;
      saveCurrentPosition();
      saveResumeState();
    });

    playerService.player.durationStream.distinct().listen((dur) {
      if (dur != null) duration.value = dur;
    });

    playerService.player.playingStream.distinct().listen((playing) {
      isPlaying.value = playing;
      storage.write(_prefsIsPlaying, playing);
    });
  }

  Future<void> loadPlaylist({
    required String playlistId,
    required List<Audio> audios,
    required int startIndex,
    required String author,
    required String imageUrl,
  }) async {
    if (currentPlaylistId.value != playlistId) {
      _clearPlaylistState();
    }

    currentPlaylistId.value = playlistId;
    playlist = audios;
    currentIndex.value = startIndex;
    currentAudio.value = audios[startIndex];

    storage.write(_prefsPlaylistId, playlistId);

    final raw = storage.read(_prefsAudioPositions);
    final positions = raw is Map
        ? raw.map(
            (k, v) => MapEntry(k.toString(), int.tryParse(v.toString()) ?? 0))
        : <String, int>{};
    final positionMs = positions[audios[startIndex].url] ?? 0;
    final shouldAutoPlay = storage.read<bool>(_prefsIsPlaying) ?? false;

    try {
      await playerService.playAudios(
        audios,
        startIndex,
        author: author,
        imageUrl: imageUrl,
        initialPosition: Duration(milliseconds: positionMs),
        autoPlay: true, // always autoplay when loading directly
      );
      isPlaying.value = true;
    } catch (e) {
      print("Audio play error: $e");
    }
  }

  void togglePlayPause() {
    playerService.togglePlayPause();
    storage.write(_prefsIsPlaying, !isPlaying.value);
  }

  void nextAudio() {
    if (currentIndex.value < playlist.length - 1) {
      saveCurrentPosition();
      _jumpTo(currentIndex.value + 1);
    }
  }

  void previousAudio() {
    if (currentIndex.value > 0) {
      saveCurrentPosition();
      _jumpTo(currentIndex.value - 1);
    }
  }

  void stopAudio() {
    _clearResumeState();
    playerService.stop();
  }

  void seek(Duration pos) => playerService.seek(pos);

  void _jumpTo(int index) {
    currentIndex.value = index;
    currentAudio.value = playlist[index];

    final raw = storage.read(_prefsAudioPositions);
    final positions = raw is Map
        ? raw.map(
            (k, v) => MapEntry(k.toString(), int.tryParse(v.toString()) ?? 0))
        : <String, int>{};

    final positionMs = positions[playlist[index].url] ?? 0;
    playerService.skipToIndex(index, Duration(milliseconds: positionMs));
    saveResumeState();
  }

  void saveResumeState() {
    if (currentAudio.value == null) return;

    storage.write(_prefsAudioIndex, currentIndex.value);
    storage.write(_prefsAudioUrl, currentAudio.value!.url);
  }

  void saveCurrentPosition() {
    if (currentAudio.value == null) return;

    final raw = storage.read(_prefsAudioPositions);
    final positions = raw is Map
        ? raw.map(
            (k, v) => MapEntry(k.toString(), int.tryParse(v.toString()) ?? 0))
        : <String, int>{};

    positions[currentAudio.value!.url] = position.value.inMilliseconds;
    storage.write(_prefsAudioPositions, positions);
  }

  void _clearResumeState() {
    storage.remove(_prefsPlaylistId);
    storage.remove(_prefsAudioIndex);
    storage.remove(_prefsAudioUrl);
    storage.remove(_prefsIsPlaying);
  }

  void _clearPlaylistState() {
    duration.value = Duration.zero;
    position.value = Duration.zero;
    isPlaying.value = false;
    currentIndex.value = 0;
    currentAudio.value = null;
    playlist = [];
  }

  Future<void> resumeLastAudio({
    required String playlistId,
    required List<Audio> audios,
    required String author,
    required String imageUrl,
    required int fallbackIndex,
    bool forceStartIndex = false,
  }) async {
    if (forceStartIndex) {
      await loadPlaylist(
        playlistId: playlistId,
        audios: audios,
        startIndex: fallbackIndex,
        author: author,
        imageUrl: imageUrl,
      );
      return;
    }

    String? savedPlaylistId;
    int? savedIndex;
    String? savedUrl;
    bool shouldAutoPlay = false;

    try {
      savedPlaylistId = storage.read<String>(_prefsPlaylistId);
      savedIndex = storage.read<int>(_prefsAudioIndex);
      savedUrl = storage.read<String>(_prefsAudioUrl);
      shouldAutoPlay = storage.read<bool>(_prefsIsPlaying) ?? false;
    } catch (e) {
      print("Error reading storage: $e");
      await loadPlaylist(
        playlistId: playlistId,
        audios: audios,
        startIndex: fallbackIndex,
        author: author,
        imageUrl: imageUrl,
      );
      return;
    }

    if (savedPlaylistId != playlistId ||
        savedIndex == null ||
        savedIndex >= audios.length ||
        audios[savedIndex].url != savedUrl) {
      await loadPlaylist(
        playlistId: playlistId,
        audios: audios,
        startIndex: fallbackIndex,
        author: author,
        imageUrl: imageUrl,
      );
      return;
    }

    final raw = storage.read(_prefsAudioPositions);
    final positions = raw is Map
        ? raw.map((key, value) =>
            MapEntry(key.toString(), int.tryParse(value.toString()) ?? 0))
        : <String, int>{};

    final positionMs = positions[audios[savedIndex].url] ?? 0;

    currentPlaylistId.value = playlistId;
    playlist = audios;
    currentIndex.value = savedIndex;
    currentAudio.value = audios[savedIndex];

    try {
      await playerService.playAudios(
        audios,
        savedIndex,
        author: author,
        imageUrl: imageUrl,
        initialPosition: Duration(milliseconds: positionMs),
        autoPlay: shouldAutoPlay,
      );
      isPlaying.value = shouldAutoPlay;
    } catch (e) {
      print("Resume error: $e");
      await loadPlaylist(
        playlistId: playlistId,
        audios: audios,
        startIndex: fallbackIndex,
        author: author,
        imageUrl: imageUrl,
      );
    }
  }

  void saveState() {
    saveCurrentPosition();
    saveResumeState();
  }
}
