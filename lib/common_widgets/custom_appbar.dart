import 'package:flutter/material.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustomAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: TextFontStyle.headLine20w600cFFFFFFLato,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: AppColor.onboardColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
