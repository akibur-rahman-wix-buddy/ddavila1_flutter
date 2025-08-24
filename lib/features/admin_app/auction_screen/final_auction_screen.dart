// ignore_for_file: library_private_types_in_public_api

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalAuctionScreen extends StatefulWidget {
  const FinalAuctionScreen({super.key});

  @override
  _FinalAuctionScreenState createState() => _FinalAuctionScreenState();
}

class _FinalAuctionScreenState extends State<FinalAuctionScreen> {
  bool isAuction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Auction Radio Button Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Auction',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 18.sp,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Radio<bool>(
                    value: false,
                    groupValue: isAuction,
                    activeColor: AppColor.blackColor,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isAuction = value;
                          print('Selected value: $isAuction');
                        });
                      }
                    },
                  ),
                  Text(
                    'No',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Radio<bool>(
                    value: true,
                    groupValue: isAuction,
                    activeColor: AppColor.blackColor,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isAuction = value;
                          print('Selected value: $isAuction');
                        });
                      }
                    },
                  ),
                  Text(
                    'Yes',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              if (isAuction) ...[
                // Auction Yes Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starting Price',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'Enter Starting Price',
                      onChanged: (value) {
                        // Handle the input value
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Auction End Date',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'Select auction end date',
                      onChanged: (value) {
                        // Handle the input value
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ship within (days)',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                hintText: '0',
                                fieldWidth: 160.w,
                                onChanged: (value) {
                                  // Handle the input value
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Cost',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                hintText: '0',
                                fieldWidth: 160.w,
                                onChanged: (value) {
                                  // Handle the input value
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ] else ...[
                // Auction No Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buy Now Price',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'Enter Buy Now Price',
                      onChanged: (value) {
                        // Handle the input value
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ship within (days)',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                hintText: '0',
                                fieldWidth: 160.w,
                                onChanged: (value) {
                                  // Handle the input value
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Cost',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                hintText: '0',
                                fieldWidth: 160.w,
                                onChanged: (value) {
                                  // Handle the input value
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              SizedBox(height: 32.h),
              // Button Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onTap: () {
                      // Handle back button action
                    },
                    text: 'Back',
                    context: context,
                    minWidth: 160.w,
                    color: AppColor.cF3F2F2,
                    borderRadius: 12.r,
                    textStyle:
                        TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c3988FF,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      // Handle next button action
                    },
                    text: 'Next',
                    context: context,
                    minWidth: 160.w,
                    color: AppColor.c3988FF,
                    borderRadius: 12.r,
                    textStyle:
                        TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.cFFFFFF,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
