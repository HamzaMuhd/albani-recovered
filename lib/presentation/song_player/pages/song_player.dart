import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/constants/app_urls.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SongPlayer extends StatelessWidget {
  const SongPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: BasicAppbar(
        //   title: const Text(
        //     'Now Playing',
        //     style: TextStyle(
        //       fontSize: 18,
        //     ),
        //   ),
        //   action: IconButton(
        //       onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        // ),
        // body: BlocProvider(
        //   create: (_) =>
        //       SongPlayerCubit()..loadSong('assets/audio/Talkhis_1.mp3'),
        //   child: SingleChildScrollView(
        //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        //     child: Column(
        //       children: [
        //         _songCover(context),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         _songDetail(),
        //         const SizedBox(
        //           height: 30,
        //         ),
        //         _songPlayer(context)
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
