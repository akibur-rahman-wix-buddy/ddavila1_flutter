import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final VoidCallback? onCallBack;
  final double? height;
  final double? minWidth;
  final Color? color;
  final double? borderRadius;
  final TextStyle? textStyle;
  final BuildContext context;
  final Icon? icon;
  final SvgPicture? svgIcon;
  final Color? borderColor;
  final bool isIconFirst;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.onCallBack,
    this.height,
    this.minWidth,
    this.color,
    this.borderRadius,
    this.textStyle,
    required this.context,
    this.icon,
    this.svgIcon,
    this.borderColor,
    this.isIconFirst = false, // Default: Text first, icon after
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? widget.onCallBack,
      child: Container(
        height: widget.height ?? 52.h,
        width: widget.minWidth ?? 310.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color ?? AppColor.c4275f6,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 67.r),
          border: Border.all(
            color: widget.borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.isIconFirst
              ? [
                  // If icon should be first, place icon before text
                  if (widget.icon != null || widget.svgIcon != null)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: widget.svgIcon ?? widget.icon,
                    ),
                  Text(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                    style: widget.textStyle ??
                        TextFontStyle.textLine16w500cFFFFFFLato
                            .copyWith(color: AppColor.whiteColor),
                  ),
                ]
              : [
                  // If icon should be last, place text before icon
                  Text(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                    style: widget.textStyle ??
                        TextFontStyle.buttonTextStyle.copyWith(
                          color: AppColor.whiteColor,
                        ),
                  ),
                  if (widget.icon != null || widget.svgIcon != null)
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: widget.svgIcon ?? widget.icon,
                    ),
                ],
        ),
      ),
    );
  }
}
