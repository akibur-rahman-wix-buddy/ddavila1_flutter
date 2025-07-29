// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/app_image.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
// import 'package:ddavila/common_widgets/custom_button.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(
//             16,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(AppImages.appLogo, height: 100, width: 200),
//               CustomButton(
//                 minWidth: double.infinity,
//                 text: 'Login',
//                 context: context,
//                 color: AppColor.c4275f6,
//               ),
//               SizedBox(height: 16),
//               CustomButton(
//                 minWidth: double.infinity,
//                 text: 'Sign Up',
//                 context: context,
//                 textStyle: TextFontStyle.buttonTextStyle.copyWith(
//                   color: AppColor.c4275f6,
//                   fontSize: 16,
//                 ),
//                 color: AppColor.cFFFFFF,
//                 borderColor: AppColor.c4275f6,
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 250),
                  Image.asset(AppImages.appLogo, height: 100, width: 200),
                  SizedBox(height: 210),
                  CustomButton(
                    minWidth: double.infinity,
                    text: 'Login',
                    context: context,
                    color: AppColor.c4275f6,
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    onTap: () {
                      NavigationService.navigateTo(Routes.roleScreen);
                    },
                    minWidth: double.infinity,
                    text: 'Sign Up',
                    context: context,
                    textStyle: TextFontStyle.buttonTextStyle.copyWith(
                      color: AppColor.c4275f6,
                      fontSize: 16,
                    ),
                    color: AppColor.cFFFFFF,
                    borderColor: AppColor.c4275f6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
