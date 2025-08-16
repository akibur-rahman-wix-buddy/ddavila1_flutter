// ignore_for_file: use_key_in_widget_constructors
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityScreen extends StatefulWidget {
  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: AppColor.c4275F6,
                height: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: AppColor.c4275F6,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: AppColor.cF6F8FA,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.arrowBackWhite),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Security',
                            style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                .copyWith(
                              color: AppColor.cFFFFFF,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(70),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Remember me',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              UIHelper.horizontalSpace(10),
                              CustomToggleSwitch(),
                            ],
                          ),
                          UIHelper.verticalSpace(200),
                          CustomButton(
                            color: AppColor.cFFFFFF,
                            text: 'Change Password',
                            textStyle: TextFontStyle.textLine7w400cFFFFFFDmSans
                                .copyWith(
                              color: AppColor.c000000,
                            ),
                            borderColor: AppColor.c000000,
                            context: context,
                          ),
                          UIHelper.verticalSpace(20),
                          CustomButton(
                            text: 'Change Pin',
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({super.key});

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOn = !_isOn;
        });
      },
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _isOn ? Colors.blue : AppColor.cDFE1E6,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: _isOn ? 32 : 2,
              top: 2,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
