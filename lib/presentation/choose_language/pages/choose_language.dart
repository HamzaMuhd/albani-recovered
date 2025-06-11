import 'dart:ui';

import 'package:albani/common/widgets/button/basic_app_button.dart';
import 'package:albani/core/configs/assets/app_images.dart';
import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/data/repositories/text_data.dart';
import 'package:albani/presentation/choose_language/controller/language_controller.dart';
import 'package:albani/presentation/choose_mode/pages/choose_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());

    return Scaffold(
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppImages.introBG))),
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40,
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppVectors.logo,
                    width: 200,
                    height: 200,
                  )),
              // Align(
              //     alignment: Alignment.center,
              //     child: Image.asset(
              //       AppImages.albani,
              //     )),
              const Spacer(),
              Text(
                AppStrings.selectLanguage.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          languageController.selectLanguage('en');
                        },
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xff30393C).withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                AppVectors.english,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'English',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          languageController.selectLanguage('ha');
                        },
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xff30393C).withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                AppVectors.hausa,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Hausa',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.grey),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              BasicAppButton(
                  onPressed: () {
                    GetStorage().write('isFirstTime', false);
                    Get.to(() => const ChooseModePage());
                  },
                  title: AppStrings.continueText.tr)
            ],
          ),
        ),
      ]),
    );
  }
}
