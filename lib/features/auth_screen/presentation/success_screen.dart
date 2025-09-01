import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Center the content both horizontally and vertically
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Vertically center the content
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Horizontally center the content
              children: [
                SizedBox(height: 210),
                SvgPicture.asset(AppIcons.doneIcon, height: 100, width: 100),
                SizedBox(height: 24),
                Text(
                  'Success!',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'You have successfully registered in our app and start working in it.',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center, // Center-align the text
                ),
                SizedBox(height: 200),
                CustomButton(
                  text: 'Start Shopping',
                  context: context,
                  minWidth: double.infinity,
                  onTap: () {
                    NavigationService.navigateTo(Routes.navigationScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
