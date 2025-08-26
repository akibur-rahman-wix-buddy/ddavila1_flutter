// // ignore_for_file: unused_local_variable, prefer_final_fields
//
// import 'dart:convert';
// import 'dart:developer';
// import 'package:ddavila/features/onboarding_screen/onboarding_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:ddavila/helpers/all_routes.dart';
// import 'package:ddavila/helpers/navigation_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'constants/app_constants.dart';
// import 'helpers/di.dart';
// import 'helpers/helper_methods.dart';
// import 'networks/dio/dio.dart';
// import 'welcome_screen.dart';
//
// class Loading extends StatefulWidget {
//   const Loading({super.key});
//   @override
//   State<Loading> createState() => _LoadingState();
// }
//
// class _LoadingState extends State<Loading> {
//   bool _isLoading = true;
//   bool _isPremium = false;
//
//   @override
//   void initState() {
//     super.initState();
//     loadInitialData();
//   }
//
//   Future<void> loadInitialData() async {
//     await setInitValue();
//
//     try {
//       if (appData.read(kKeyIsLoggedIn) == true) {
//         String token = appData.read(kKeyAccessToken);
//         String? usersId = appData.read(kKeyUserID);
//         log(">>>>>>>Loading token : >>>>>>>>>>>>>>>>>Onboarding completed: $token");
//         DioSingleton.instance.update(token);
//
//         // await PurchaseHelper.init(
//         //   id: usersId,
//         // );
//
//         // Check if token is valid
//         if (await isTokenExpired(token)) {
//           navigateToLogin();
//           return;
//         }
//
//         // Sync the onboarding completed status from SharedPreferences to appData
//         bool isOnboardingCompleted = await _checkOnboardingStatus();
//         appData.write(onBoardingCompleted,
//             isOnboardingCompleted); // Sync appData with SharedPreferences
//         print(
//             ">>>>>>>Loading 1: >>>>>>>>>>>>>>>>>Onboarding completed: $isOnboardingCompleted");
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//         }
//         log('is premium: $_isPremium');
//       }
//     } catch (error) {
//       log("Error during initialization: $error");
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void navigateToLogin() {
//     appData.write(kKeyIsLoggedIn, false); // Update login state
//     NavigationService.navigateTo(Routes.loginScreen); // Adjust your route name
//   }
//
//   Future<bool> isTokenExpired(String? token) async {
//     if (token == null) return true;
//
//     try {
//       // Decode the token to check expiration
//       final parts = token.split('.');
//       if (parts.length != 3) return true;
//
//       final payload = jsonDecode(
//           utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
//       final expiry =
//           payload['exp'] as int?; // Token expiration time (UNIX timestamp)
//
//       if (expiry == null) return true;
//
//       final now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
//       return now >= expiry;
//     } catch (e) {
//       log("Error decoding token: $e");
//       return true;
//     }
//   }
//
//   Future<bool> _checkOnboardingStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? completed = prefs.getBool(onBoardingCompleted);
//     print(
//         ">>>>>>>>>>>>>>>>>>>>>>>> Retrieved Onboarding Completed value: $completed");
//     // Sync the retrieved value to appData
//     appData.write(onBoardingCompleted, completed ?? false);
//     return completed ?? false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const WelcomeScreen();
//     } else {
//       return OnboardingScreen();
//     }
//   }
// }


// ignore_for_file: unused_local_variable

import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/navigation_screen.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'features/auth_screen/presentation/login_screen.dart';
import 'helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'networks/dio/dio.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }



  loadInitialData() async {

    await Future.delayed(const Duration(seconds: 2));
    await setInitValue();

    bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
    bool firstTime = appData.read(kKeyIsFirstTime) ?? false;
    if (isLoggedIn) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      print(
          ">>>>>>>>>>>>>>>>>>>> here is the access info :${appData.read(kKeyIsLoggedIn)}");
      appData.write(kKeyIsLoggedIn, true);
      print(
          ">>>>>>>>>>>>>>>>>>>> here is the access info :${appData.read(kKeyIsLoggedIn)}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationScreen()),
      );
    } else {
      // Navigate to LoginScreen if not logged in
      NavigationService.navigateToReplacement(Routes.loginScreen);
    }

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {


      print(">>>>>>>>>>>>>>>>>>>> here is the access info :${appData.read(kKeyIsLoggedIn)}");



      return appData.read(kKeyIsLoggedIn)
          ? const NavigationScreen()
          : const LoginScreen();
    }
  }
}