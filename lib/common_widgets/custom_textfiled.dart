import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_helper/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final double? fieldHeight;
  final double? fieldWidth;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintTextStyle;
  final Color? fieldColor;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.inputType,
    this.fieldHeight,
    this.fieldWidth,
    this.validator,
    this.isEnabled = true,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius,
    this.padding,
    this.hintTextStyle,
    this.fieldColor,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: padding ?? const EdgeInsets.fromLTRB(15, 30, 0, 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: fieldColor ?? AppColor.whiteColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        border: Border.all(
          color: AppColor.blackColor.withOpacity(0.1),
          width: 1.w,
        ),
      ),
      height: fieldHeight ?? 55.h,
      width: fieldWidth ?? 343.w,
      child: TextFormField(
        controller: controller,
        validator: validator,
        enabled: isEnabled,
        obscureText: obscureText,
        readOnly: readOnly,
        minLines: 1,
        style: const TextStyle(color: AppColor.blackColor),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 17.h),
          hintText: hintText,
          hintStyle: hintTextStyle ??
              TextStyle(
                fontSize: 12.sp,
                color: AppColor.c7B7B7B,
                fontFamily: 'Roboto',
                height: 1.50.h,
                fontWeight: FontWeight.w300,
              ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColor.c000000,
            fontFamily: 'Roboto',
            height: 1.50.h,
            fontWeight: FontWeight.w300,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        keyboardType: inputType,
      ),
    );
  }
}
