
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/user_app/products_screen/widget/active_auction_section.dart';
import 'package:flutter/material.dart';
import '../model/live_action_details_model.dart';
import 'auction_closed_section.dart';
import 'bit_time_and_time_info.dart';



class AuctionDetailsContainer extends StatelessWidget {
  final ProductData product;
  final bool? timeFinished;
  final BidData? winningBit;
  final dynamic myId;
  final dynamic myShippingCost;
  final dynamic productPercentage;
  final dynamic stateName;

  const AuctionDetailsContainer({
    Key? key,
    required this.product,
    this.timeFinished,
    this.winningBit,
    required this.myId,
    required this.myShippingCost,
    required this.productPercentage,
    required this.stateName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.cDCE4E6,
            blurRadius: 9.9,
            offset: Offset(0, 0.1),
          )
        ],
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceAndTimeInfo(product: product),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Live Auction',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 14.0,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${product.bid?.toString() ?? "0"} Bids made',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 12.0,
                    color: AppColor.c000000,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Show appropriate UI based on timeFinished
            timeFinished == true
                ? AuctionClosedSection(
              winningBit: winningBit,
              myId: myId,
              myShippingCost: myShippingCost,
              productPercentage: productPercentage,
              stateName: stateName,
            )
                : ActiveAuctionSection(product: product),
          ],
        ),
      ),
    );
  }
}