import 'package:albani/data/models/subcategories_model.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();
  final _playlist = <MediaItem>[];

  MyAudioHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);

    // Broadcast current media item to audio_service
    _player.currentIndexStream.listen((index) {
      if (index != null && index < _playlist.length) {
        mediaItem.add(_playlist[index]);
      }
    });

    // Optional: Listen to duration changes
    _player.durationStream.listen((d) {
      final current = mediaItem.value;
      if (current != null && d != null) {
        mediaItem.add(current.copyWith(duration: d));
      }
    });
  }

  /// Transform JustAudio state to AudioService state
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        _player.playing ? MediaControl.pause : MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      androidCompactActionIndices: const [0, 1, 3],
      playing: _player.playing,
      processingState: {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      updateTime: DateTime.now(),
    );
  }

  Future<void> playAudios(
    List<Audio> audios,
    int startIndex, {
    required String author,
    required String imageUrl,
  }) async {
    _playlist.clear();

    final mediaItems = audios.map((audio) {
      return MediaItem(
        id: audio.url,
        title: audio.title,
        album: 'Albani',
        artist: author,
        duration: Duration.zero,
        artUri: Uri.tryParse(imageUrl),
      );
    }).toList();

    _playlist.addAll(mediaItems);
    queue.add(_playlist);

    final sources =
        audios.map((a) => AudioSource.uri(Uri.parse(a.url))).toList();
    await _player.setAudioSource(ConcatenatingAudioSource(children: sources));
    await skipToQueueItem(startIndex);
    await play();
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < _playlist.length) {
      await _player.seek(Duration.zero, index: index);
    }
  }
}
