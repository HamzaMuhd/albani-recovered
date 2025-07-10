import 'package:albani/data/models/subcategories_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;
  AudioPlayerService() {
    // Log playback events to track state
    _player.playbackEventStream.listen((event) {
      debugPrint(
          'Playback event: ${event.processingState}, playing=${_player.playing}');
    });
  }

  Future<void> playAudios(List<Audio> audios, int startIndex,
      {required String author, required String imageUrl}) async {
    final sources = audios
        .map((audio) => AudioSource.uri(
              Uri.parse(audio.url),
              tag: MediaItem(
                id: audio.url,
                title: audio.title,
                album: 'Albani',
                artist: author,
                artUri: Uri.tryParse(imageUrl),
              ),
            ))
        .toList();

    try {
      await _player.setAudioSources(
        sources,
        initialIndex: startIndex,
        initialPosition: Duration.zero,
      );

      await _player.play(); // ✅ Only start after setAudioSources
    } catch (e) {
      print("Error starting audio: $e");
    }
  }

  void togglePlayPause() => _player.playing ? _player.pause() : _player.play();

  void stop() => _player.stop();
  void seek(Duration position) => _player.seek(position);
  void skipToNext() => _player.seekToNext();
  void skipToPrevious() => _player.seekToPrevious();
  void skipToIndex(int index) => _player.seek(Duration.zero, index: index);
  void dispose() {
    _player.dispose();
    debugPrint('AudioPlayer disposed');
  }
}
