// ignore_for_file: use_key_in_widget_constructors
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                    MediaQuery.of(context)
                        .padding
                        .top, // * Adjust for AppBar and status bar
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
                        color: Colors.white, // * Removed fixed height
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
                  // * App Bar
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.arrowBackWhite),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Edit Profile',
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
                  // * Container
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors
                          .white, // Overwrites Colors.green for consistency
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Full Name',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(6),
                          CustomTextField(
                            borderRadius: 40,
                            hintText: 'Name',
                            hintTextStyle: TextFontStyle
                                .textLine7w400cFFFFFFDmSans
                                .copyWith(
                              color: AppColor.c000000,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                AppIcons.editProfileIcon,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(6),
                          CustomTextField(
                            borderRadius: 40,
                            hintText: 'zobayer.dev@gmail.com',
                            hintTextStyle: TextFontStyle
                                .textLine7w400cFFFFFFDmSans
                                .copyWith(
                              color: AppColor.c000000,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                AppIcons.profileEmail,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Date of Birth',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(6),
                          CustomTextField(
                            borderRadius: 40,
                            hintText: '01 April 2004',
                            hintTextStyle: TextFontStyle
                                .textLine7w400cFFFFFFDmSans
                                .copyWith(
                              color: AppColor.c000000,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                AppIcons.profileCalendar,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Contact',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(6),
                          CustomTextField(
                            borderRadius: 40,
                            hintText: '+8801615257555',
                            hintTextStyle: TextFontStyle
                                .textLine7w400cFFFFFFDmSans
                                .copyWith(
                              color: AppColor.c000000,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                AppIcons.profileCalendar,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Address',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(6),
                          CustomTextField(
                            fieldHeight: 100,
                            borderRadius: 10,
                            hintText: 'Address....',
                            hintTextStyle: TextFontStyle
                                .textLine7w400cFFFFFFDmSans
                                .copyWith(
                              color: AppColor.c000000,
                            ),
                          ),
                          UIHelper.verticalSpace(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                color: AppColor.cFFFFFF,
                                text: 'Cancel',
                                textStyle: TextFontStyle
                                    .textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                ),
                                borderColor: AppColor.c000000,
                                context: context,
                                minWidth: 160,
                              ),
                              CustomButton(
                                text: 'Update',
                                context: context,
                                minWidth: 160,
                              ),
                            ],
                          )
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
