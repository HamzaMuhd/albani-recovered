import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/home/widgets/news_songs.dart';
import 'package:flutter/material.dart';

class AudioTab extends StatelessWidget {
  const AudioTab({
    super.key,
    required TabController tabController,
    required this.context,
  }) : _tabController = tabController;

  final TabController _tabController;
  final BuildContext context;

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
            tabs: const [
              Text(
                'Books',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                'Tafsir',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                'Lecture',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                'Sermon',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ]),
        SizedBox(
          height: 260,
          child: TabBarView(controller: _tabController, children: [
            const NewsSongs(),
            Container(),
            Container(),
            Container(),
          ]),
        ),
      ],
    );
  }
}
