import 'package:custom_social_button/custom_social_button.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.appLogo,
                height: 100,
                width: 200,
              ),
              SizedBox(height: 72),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome!',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.c000000,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'please login or sign up to continue our app',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.cAEAEAE,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.c000000,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      AppIcons.checkMark,
                    ),
                  ),
                  hintText: 'Enter your email',
                  hintStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.cAEAEAE,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.c000000,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      AppIcons.checkMark,
                    ),
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.cAEAEAE,
                  ),
                ),
              ),
              SizedBox(height: 56),
              CustomButton(
                text: 'Login',
                context: context,
                minWidth: double.infinity,
              ),
              SizedBox(height: 19),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: const Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Text(
                    'Or',
                    style: TextFontStyle.textLine12w300c919191Roboto.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.c919191,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 150,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: const Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 19),
              SocialButton(
                title: 'google',
                buttonTitle: 'Sign in with Google',
                color: AppColor.cFFFFFF,
                height: 52.0,
                width: double.infinity,
                borderRadius: 67.0,
                borderColor: AppColor.c666666.withAlpha(35),
                borderWidth: 2.0,
                textStyle: const TextStyle(
                  color: AppColor.c666666,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                iconHeight: 24.0,
                iconWidth: 24.0,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Facebook button tapped!',
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      NavigationService.navigateTo(Routes.signUpScreen);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColor.c4275f6,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
