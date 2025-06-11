import 'package:albani/core/configs/constants/app_urls.dart';
import 'package:albani/core/configs/constants/appkey.dart';
import 'package:albani/data/models/user_models.dart';
import 'package:albani/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = "".obs;
  final user = UserModel().obs;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '429620588278-hn7lhb2gbj0aquvdod640ntv4k2crti1.apps.googleusercontent.com',
  );

  final storage = GetStorage();

  static void showSuccess({
    required String message,
    required String fullName,
  }) {
    Get.snackbar(
      "Success 🎉, $message",
      "Welcome, $fullName!",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 5),
    );
  }

  static void showError({
    required String errorMessage,
  }) {
    Get.snackbar(
      "Error 😞",
      errorMessage,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void onInit() {
    super.onInit();
    loadUserFromStorage();
  }

  void loadUserFromStorage() {
    final userJson = storage.read('user');
    if (userJson != null) {
      final userMap = json.decode(userJson);
      user.value = UserModel.fromJson(userMap);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      isLoading.value = true;
      if (account == null) {
        print('Login aborted');
        return;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;

      if (idToken == null) {
        print('ID Token is null');
        return;
      }

      final response = await http.post(
        Uri.parse(AppUrls.googleUrl), // Replace with your NestJS URL
        headers: {
          'Content-Type': 'application/json',
          "x-api-key": AppStrings.apiKey,
        },
        body: jsonEncode({'idToken': idToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UserModel loggedInUser = UserModel.fromJson(responseData['user']);
        final String message = responseData['message'];
        final String token = responseData['token'];
        storage.write('token', token);
        storage.write('user', json.encode(loggedInUser.toJson()));
        storage.write('auth_method', 'google');

        user.value = loggedInUser;
        isLoading.value = false;
        print(responseData);
        showSuccess(
            message: message, fullName: responseData['user']['full_name']);
        Get.offAll(() => const NavigationMenu());
      } else {
        errorMessage.value = jsonDecode(response.body)['message'];
        print(errorMessage);
        isLoading.value = false;
        showError(errorMessage: errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print(errorMessage);
      isLoading.value = false;
      showError(errorMessage: errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(AppUrls.login),
        headers: {
          "Content-Type": "application/json",
          "x-api-key": AppStrings.apiKey, // Add the x-api-key here
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UserModel loggedInUser = UserModel.fromJson(responseData['user']);
        final String message = responseData['message'];
        final String token = responseData['token'];
        storage.write('token', token);
        storage.write('user', json.encode(loggedInUser.toJson()));
        storage.write('auth_method', 'local');

        user.value = loggedInUser;
        isLoading.value = false;
        print(responseData);
        showSuccess(
            message: message, fullName: responseData['user']['full_name']);
        Get.offAll(() => const NavigationMenu());
      } else {
        errorMessage.value = jsonDecode(response.body)['message'];
        print(errorMessage);
        isLoading.value = false;
        showError(errorMessage: errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print(errorMessage);
      isLoading.value = false;
      showError(errorMessage: errorMessage.value);
    }
  }

  Future<void> register(String fullName, String email, String password) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(AppUrls.register),
        headers: {
          "Content-Type": "application/json",
          "x-api-key": AppStrings.apiKey,
        },
        body: jsonEncode({
          "full_name": fullName,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UserModel loggedInUser = UserModel.fromJson(responseData['user']);
        final String message = responseData['message'];
        final String token = responseData['token'];
        storage.write('token', token);
        storage.write('user', json.encode(loggedInUser.toJson()));
        storage.write('auth_method', 'local');

        user.value = loggedInUser;
        print(responseData);
        isLoading.value = false;
        showSuccess(
            message: message, fullName: responseData['user']['full_name']);
        Get.offAll(() => const NavigationMenu());
      } else {
        errorMessage.value = jsonDecode(response.body)['message'];
        print(response.body);
        isLoading.value = false;
        showError(errorMessage: errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print(errorMessage);
      isLoading.value = false;
      showError(errorMessage: errorMessage.value);
    }
  }

  bool get isLoggedIn => storage.hasData('token');

  Future<void> logout() async {
    final isFirstTime = storage.read('isFirstTime');
    final authMethod = storage.read('auth_method');

    if (authMethod == 'google') {
      await googleSignIn.signOut();
    }

    storage.erase();
    storage.write('isFirstTime', isFirstTime ?? false);
    Get.offAll(() => const NavigationMenu());
  }

  void handleAuthResponse(Map<String, dynamic> data) {
    final String token = data['token'];
    final Map<String, dynamic> user = data['user'];

    Get.snackbar('Success', 'Logged in as ${user['full_name']}');
  }
}
