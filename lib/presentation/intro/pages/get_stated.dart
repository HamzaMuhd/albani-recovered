import 'package:albani/common/widgets/button/basic_app_button.dart';
import 'package:albani/core/configs/assets/app_images.dart';
import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/data/repositories/text_data.dart';
import 'package:albani/presentation/choose_language/pages/choose_language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStatedPage extends StatelessWidget {
  const GetStatedPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(AppStrings.title.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 21,
              ),
              Text(
                AppStrings.about.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              BasicAppButton(
                  onPressed: () {
                    Get.to(() => const ChooseLanguagePage());
                  },
                  title: AppStrings.getStarted.tr)
            ],
          ),
        ),
      ]),
    );
  }
}
