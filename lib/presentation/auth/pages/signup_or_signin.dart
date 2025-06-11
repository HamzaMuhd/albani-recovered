import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/common/widgets/button/basic_app_button.dart';
import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/core/configs/theme/app_colors.dart';
import 'package:albani/navigation_menu.dart';
import 'package:albani/presentation/auth/controller/auth_controller.dart';
import 'package:albani/presentation/auth/pages/signin.dart';
import 'package:albani/presentation/auth/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignupOrSigninPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          BasicAppbar(
              action: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const NavigationMenu()),
                        (root) => false);
                  },
                  icon: const Row(
                    children: [
                      Text('Skip'),
                      Icon(Icons.skip_next),
                    ],
                  ))),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppVectors.logo,
                    width: 200,
                    height: 200,
                  ),
                  // const SizedBox(
                  //   height: 55,
                  // ),
                  const Text(
                    'Enjoy Listening To Albani',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Albani is an Islamic Lecture audio streeming and islamic media service provider',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: AppColors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: BasicAppButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignupPage()));
                            },
                            title: 'Register',
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SigninPage()));
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: DarkMode(context).isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => ElevatedButton.icon(
                      onPressed: () {
                        authController.signInWithGoogle();
                      },
                      icon: Image.asset(
                        AppVectors.google, // Add a Google icon image here
                        height: 20,
                        width: 20,
                      ),
                      label: authController.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Continue with Google',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
