import 'package:albani/common/widgets/appbar/app_bar.dart';
import 'package:albani/common/widgets/button/basicbutton.dart';
import 'package:albani/core/configs/assets/app_vectors.dart';
import 'package:albani/data/models/validation.dart';
import 'package:albani/presentation/auth/controller/auth_controller.dart';
import 'package:albani/presentation/auth/pages/signup.dart';
import 'package:albani/presentation/home/pages/home.dart';
import 'package:albani/presentation/splash/widgets/costom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final FocusNode fullnameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppbar(
          title: Image.asset(
            AppVectors.logo,
            height: 110,
            width: 110,
          ),
          action: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage()),
                    (root) => false);
              },
              icon: const Row(
                children: [
                  Text('Skip'),
                  Icon(Icons.skip_next),
                ],
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerText(),
                const SizedBox(
                  height: 50,
                ),
                customTextField(
                  context,
                  controller: emailController,
                  focusNode: emailFocus,
                  label: "Email",
                  hintText: "Enter your email address",
                  validator: Validators.validateEmail,
                  onFieldSubmitted: (_) {
                    passwordFocus.requestFocus();
                  },
                ),
                const SizedBox(height: 20),
                customTextField(
                  context,
                  controller: passwordController,
                  focusNode: passwordFocus,
                  label: "Password",
                  hintText: "Enter your password",
                  isObscure: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => BasicButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        authController.login(emailController.text.trim(),
                            passwordController.text);
                      }
                    },
                    title: authController.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
              onPressed: () {
                Get.to(() => SignupPage());
              },
              child: const Text('Register'))
        ],
      ),
    );
  }
}
