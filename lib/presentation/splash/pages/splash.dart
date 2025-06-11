import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/navigation_menu.dart';
import 'package:albani/presentation/auth/controller/auth_controller.dart';
import 'package:albani/presentation/auth/pages/signup_or_signin.dart';
import 'package:albani/presentation/intro/pages/get_stated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.put(AuthController());
    bool isFirstTime = GetStorage().read('isFirstTime') ?? true;
    Future.delayed(const Duration(seconds: 3), () {
      final target = auth.isLoggedIn
          ? const NavigationMenu()
          : isFirstTime
              ? const GetStatedPage()
              : SignupOrSigninPage();

      Get.off(() => target);
    });

    return Scaffold(
      body: Center(
        child: Image.asset(AppVectors.logo),
      ),
    );
  }
}
