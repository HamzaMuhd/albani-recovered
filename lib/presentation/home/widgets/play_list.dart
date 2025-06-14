import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/audio/full_playlist.dart';
import 'package:albani/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Playlist',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              GestureDetector(
                onTap: () => Get.to(() => const FullPlaylistScreen()),
                child: const Text(
                  'See More',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xffC6C6C6),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        // 👇 Expanded gives ListView proper constraints
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              itemCount: 20,
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
                              color: DarkMode(context).isDarkMode
                                  ? AppColors.darkGrey
                                  : const Color(0xffE6E6E6),
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: DarkMode(context).isDarkMode
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
                      Row(
                        children: [
                          const Text('52:04'),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline_outlined,
                              size: 25,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ),
        ),
      ],
    );
  }
}
