import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/core/configs/constants/audio_categories.dart';
import 'package:albani/presentation/controllers/audio_controller.dart';
import 'package:albani/presentation/home/widgets/audio_tab.dart';
import 'package:albani/presentation/home/widgets/home_categories.dart';
import 'package:albani/presentation/home/widgets/home_top_card.dart';
import 'package:albani/presentation/home/widgets/play_list.dart';
import 'package:albani/presentation/prayer_time/controller/prayertime_controller.dart';
import 'package:albani/presentation/profile_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PrayerTimesController prayerController =
      Get.put(PrayerTimesController());
  final AudioController controller = Get.put(AudioController());
  int currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      controller.currentTabIndex.value = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        action: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage()));
          },
          icon: const Icon(Icons.person),
        ),
        title: Image.asset(
          AppVectors.logo,
          height: 110,
          width: 110,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeTopCard(prayerController: prayerController, context: context),
            const SizedBox(
              height: 20,
            ),
            HomeCategories(),
            AudioTab(
              context: context,
              tabController: _tabController,
              controller: controller,
            ),
            const SizedBox(height: 20),
            Obx(() {
              final categoryId =
                  AudioCategories.all[controller.currentTabIndex.value].id;
              return SizedBox(
                  height: 300,
                  child: PlayList(
                    categoryId: categoryId,
                    controller: controller,
                  ));
            })
          ],
        ),
      ),
    );
  }
}
