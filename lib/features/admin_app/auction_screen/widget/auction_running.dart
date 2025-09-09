// ignore_for_file: must_be_immutable, non_constant_identifier_names, deprecated_member_use

import 'dart:developer';

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';

class AuctionRunningView extends StatelessWidget {
  final dynamic title;
  final dynamic currentBid;
  final dynamic timeLeft;
  final dynamic image;

  // * need to pass dynamic type because the API response is dynamic type
  dynamic price,
      type,
      shipping_cost,
      ship_within,
      auction_end_at,
      starting_price,
      imagesList,
      category_id,
      sub_category_id,
      id;
  AuctionRunningView({
    super.key,
    required this.currentBid,
    required this.title,
    required this.image,
    required this.timeLeft,
    // * need to pass dynamic type because the API response is dynamic type
    this.price,
    this.type,
    this.shipping_cost,
    this.ship_within,
    this.auction_end_at,
    this.starting_price,
    this.imagesList,
    this.category_id,
    this.sub_category_id,
    this.id,
  });

  String formatDate(dynamic date) {
    try {
      // যদি timeLeft string হয়
      DateTime parsedDate = date is String ? DateTime.parse(date) : date;
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date.toString();
    }
  }

  String descriptionText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                "$image_url$image",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title + Action Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          log('=====> Product ID: $id');
                          log('=====> Product Title: $title');
                          log('=====> Product Image: $imagesList');
                          log('=====> Product Price: $price');
                          log('=====> Product Type: $type');
                          log('=====> Product Shipping Cost: $shipping_cost');
                          log('=====> Product Ship Within: $ship_within');
                          log('=====> Product Auction End At: $auction_end_at');
                          log('=====> Product Starting Price: $starting_price');
                          log('=====> Product Category ID: $category_id');
                          log('=====> Product Sub Category ID: $sub_category_id');
                          NavigationService.navigateToWithArgs(
                              Routes.editProductsScreen, {
                            "productId": id,
                            "productType": type,
                            "productTitle": title,
                            "price": price,
                            "description": '',
                            "type": type,
                            "bid": currentBid,
                            "buyNowPrice": price,
                            "shippingCost": shipping_cost,
                            "shipWithIn": ship_within,
                            "startingPrice": starting_price,
                            "auctionEndDate": auction_end_at,
                            "categoryId": category_id,
                            "subcategoryId": sub_category_id,
                            "productImages": imagesList,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),

                  /// Current Bid
                  Row(
                    children: [
                      Text(
                        "Current Bid: ",
                        style:
                            TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "\$$currentBid",
                        style:
                            TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Ends Date
                  Text(
                    "Ends: ${formatDate(timeLeft)}",
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 14,
                      color: AppColor.c4096FF,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
