import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:albani/app.dart';
import 'package:albani/presentation/controllers/audio_handler.dart';

late final MyAudioHandler audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.munademy.albani.audio',
      androidNotificationChannelName: 'Albani Audio',
      androidNotificationOngoing: true,
    ),
  );

  runApp(const MyApp());
}
