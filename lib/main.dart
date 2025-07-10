import 'package:albani/presentation/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:albani/app.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.munademy.albani.audio',
    androidNotificationChannelName: 'Albani Audio',
    androidNotificationOngoing: true,
  );

  Get.put(AudioPlayerController());
  runApp(const MyApp());
}
