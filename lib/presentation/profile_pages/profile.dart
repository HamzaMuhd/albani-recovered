import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/core/configs/constants/app_urls.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/presentation/auth/controller/auth_controller.dart';
import 'package:albani/presentation/auth/pages/signup_or_signin.dart';
import 'package:albani/presentation/profile_pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backgroundColor:
            context.isDarkMode ? const Color(0xff2C2828) : Colors.white,
        title: const Text('Profile'),
        action: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Get.to(
              () => const SettingsPage(),
              transition: Transition.rightToLeft,
              duration: const Duration(seconds: 1),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileInfo(context),
            const SizedBox(
              height: 30,
            ),
            _favoriteSong()
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Obx(() {
      final user = authController.user.value;
      final isLoggedIn = authController.isLoggedIn;
      return Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xff2C2828) : Colors.white,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        child: isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user.picture ??
                                "https://img.icons8.com/?size=100&id=14736&format=png&color=000000"))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(user.email ?? 'No'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.fullname ?? "No",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text("You are not logged in"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => SignupOrSigninPage());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Login or Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  Widget _favoriteSong() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FAVORITE SONGS'),
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image: NetworkImage(AppUrls.firestorage)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '01 SIFA',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Sheikh Albani Zaria',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 11),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text('52:04'),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline_outlined,
                              size: 25,
                              color: AppColors.darkGrey,
                            ))
                      ],
                    )
                  ],
                );
              },
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: 6)
        ],
      ),
    );
  }
}
