import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BiddingPeopleList extends StatelessWidget {
  final String image;
  final String name;
  final String value;
  final String type;

  const BiddingPeopleList({
    super.key,
    required this.image,
    required this.name,
    required this.value,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                height: 40,
                width: 40,
                image_url + image.toString(),
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error_outline, color: Colors.red),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 14.0,
                  color: AppColor.c000000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                type,
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 12.0,
                  color: AppColor.c000000,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '\$$value',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              fontSize: 14.0,
              color: AppColor.c000000,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}