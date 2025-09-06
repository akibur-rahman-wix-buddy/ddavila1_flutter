import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/helpers/html_text_viewer.dart';
import 'package:flutter/material.dart';
import '../model/live_action_details_model.dart';


class ProductHeader extends StatelessWidget {
  final ProductData product;

  const ProductHeader({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: AppColor.blackColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title ?? "",
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              HtmlToWidgetRenderer(htmlData: product.description.toString(),)
            ],
          ),
        ),
      ),
    );
  }
}