// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSearchBar extends StatelessWidget {
  const CommonSearchBar({
    super.key,
    this.controller,
    this.onSubmitted,
    this.hintText,
    this.svgIcon,
    this.onTap,
    this.onCallBack,
  });

  final TextEditingController? controller;
  final onSubmitted;
  final String? hintText;
  final SvgPicture? svgIcon;
  final VoidCallback? onTap;
  final VoidCallback? onCallBack;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmitted,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        hintText: hintText,
        hintStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
          color: AppColor.c5A5C5F,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: SvgPicture.asset(
            height: 14.h,
            width: 14.w,
            fit: BoxFit.cover,
            AppIcons.searchIcon,
          ),
        ),

        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: svgIcon ??
                Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: SvgPicture.asset(
                    height: 14.h,
                    width: 14.w,
                    fit: BoxFit.cover,
                    AppIcons.xcloseIcon,
                  ),
                ),
          ),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide(
            color: AppColor.c5A5C5F,
            width: 1.w,
          ),
        ),
        // enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide(
            color: AppColor.c5A5C5F,
            width: 1.w,
          ),
        ),
      ),
    );
  }
}
