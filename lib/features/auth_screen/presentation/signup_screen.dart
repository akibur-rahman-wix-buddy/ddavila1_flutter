import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
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
                  'Sign Up!',
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
                  'Create an new account',
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
                  'Username',
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
                  hintText: 'Enter your username',
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
              SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
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
                  hintText: 'Enter your confirm password',
                  hintStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.cAEAEAE,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    activeColor:
                        AppColor.c4275f6, // Set the checkmark color to blue
                  ),
                  Expanded(
                    child: Text(
                      'By creating an account you have to agree with our terms & conditions.',
                      style: TextStyle(fontSize: 14),
                      softWrap:
                          true, // Ensures the text wraps into multiple lines
                      maxLines: 3, // Limit the number of lines if needed
                    ),
                  ),
                ],
              ),
              SizedBox(height: 56),
              if (isChecked)
                CustomButton(
                  text: 'Sign Up',
                  context: context,
                  minWidth: double.infinity,
                  onTap: () => NavigationService.navigateTo(
                    Routes.successScreen,
                  ),
                ),
            ],
          ),
        ),
      )),
    );
  }
}
