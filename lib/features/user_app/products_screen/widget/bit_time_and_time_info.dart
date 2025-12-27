import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/time_decriment_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/live_action_details_model.dart';



class PriceAndTimeInfo extends StatelessWidget {
  final ProductData product;

  const PriceAndTimeInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.cF3F2F2),
        borderRadius: BorderRadius.circular(12.0),
        color: AppColor.cF3F2F2,
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Starting Price',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14.0,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${product.startingPrice?.toString() ?? "0"}',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 12.0,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppImages.showImage,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'are live',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 12.0,
                        color: AppColor.c000000,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Bid Price',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14.0,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${product.highestBid?.toString() ?? "0"}',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 12.0,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: SvgPicture.asset(
                          AppIcons.blueTimer,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    StreamBuilder<String>(
                      stream: getLiveCountdownStream(isoTime: product.auctionEndAt.toString() ?? ""),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? "Loading...",
                          style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.c000000,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
