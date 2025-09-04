
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