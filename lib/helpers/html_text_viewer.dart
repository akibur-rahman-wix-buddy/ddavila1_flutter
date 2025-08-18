import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class HtmlToWidgetRenderer extends StatelessWidget {
  final String htmlData;
  final TextStyle? defaultTextStyle;
  final double glassIntensity; // 0.0 to 1.0
  final Color glassTintColor;

  const HtmlToWidgetRenderer({
    super.key,
    required this.htmlData,
    this.defaultTextStyle,
    this.glassIntensity = 0.2,
    this.glassTintColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: glassIntensity * 10,
          sigmaY: glassIntensity * 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: glassTintColor.withOpacity(glassIntensity),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: HtmlWidget(
              htmlData,
              textStyle: defaultTextStyle ?? TextStyle(
                fontSize: 14.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.black87, // Darker text for better readability on glass
              ),
            ),
          ),
        ),
      ),
    );
  }
}