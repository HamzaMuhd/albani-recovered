import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:albani/core/configs/constants/audio_categories.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/controllers/audio_controller.dart';
import 'package:albani/presentation/home/widgets/news_songs.dart';
import 'package:flutter/material.dart';

class AudioTabGrid extends StatelessWidget {
  const AudioTabGrid({
    super.key,
    required TabController tabController,
    required this.context,
    required this.controller,
  }) : _tabController = tabController;

  final TabController _tabController;
  final BuildContext context;
  final AudioController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          labelColor: context.isDarkMode ? Colors.white : Colors.black,
          indicatorColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          tabs: AudioCategories.all
              .map(
                (category) => Text(
                  category.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 260,
          child: TabBarView(
            controller: _tabController,
            children: AudioCategories.all.map((category) {
              return NewsSongs(categoryId: category.id);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
