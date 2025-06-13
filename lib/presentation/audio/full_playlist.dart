import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';

class FullPlaylistScreen extends StatelessWidget {
  const FullPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
        backgroundColor: Colors.transparent,
        foregroundColor: context.isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SongPlayer()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode
                            ? AppColors.darkGrey
                            : const Color(0xffE6E6E6),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.isDarkMode
                            ? const Color(0xff959595)
                            : const Color(0xff555555),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '01 SIFA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Sheikh Albani Zaria',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11),
                        )
                      ],
                    ),
                  ],
                ),
                const Text('52:04'),
              ],
            ),
          );
        },
      ),
    );
  }
}
