import 'package:flutter/material.dart';
import 'package:ddavila/assets_helper/app_colors.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFF9B55FD, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF9B55FD), //10%
      100: Color(0xFF9B55FD), //20%
      200: Color(0xFF9B55FD), //30%
      300: Color(0xFF9B55FD), //40%
      400: Color(0xFF9B55FD), //50%
      500: Color(0xFF9B55FD), //60%
      600: Color(0xFF9B55FD), //70%
      700: Color(0xFF9B55FD), //80%
      800: Color(0xFF9B55FD), //80%
      900: Color(0xFF9B55FD), //80%
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColor.allPrimaryColor,
      primarySwatch: CustomTheme.kToDark,
      scaffoldBackgroundColor: AppColor.scaffoldColor,
    );
  }
}
