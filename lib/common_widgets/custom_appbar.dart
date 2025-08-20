import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool? isCenterTitle;

  const CustomAppBar({super.key, required this.text,  this.isCenterTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTitle,
      title: Text(
        text,
        style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
          fontSize: 20,
          color: AppColor.blackColor,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset(
            AppIcons.arrowBack,
            width: 24,
            height: 24,
          ),
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
