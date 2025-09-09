// ignore_for_file: deprecated_member_use

import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../networks/endpoints.dart';
import 'package:intl/intl.dart';

class AuctionCompleteView extends StatelessWidget {
  final dynamic id;
  final dynamic slug;
  final dynamic title;
  final dynamic price;
  final dynamic endDate;
  final dynamic image;
  final dynamic winner;

  const AuctionCompleteView({
    super.key,
    required this.price,
    required this.title,
    required this.image,
    required this.endDate,
    required this.winner,
    required this.id,
    required this.slug,
  });

  /// date formatter
  String formatDate(dynamic date) {
    try {
      DateTime parsedDate = date is String ? DateTime.parse(date) : date;
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date.toString(); // fallback
    }
  }

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
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          NavigationService.navigateToWithArgs(
                              Routes.productsBidScreen, {
                            "productId": id.toString(),
                            "slag": slug.toString(),
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "View Details",
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

                  /// Price
                  Row(
                    children: [
                      Text(
                        "Bidding price: ",
                        style:
                            TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "\$$price",
                        style:
                            TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Auction Ended: ${formatDate(endDate)}",
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 12.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    (winner == null || winner.toString().isEmpty)
                        ? "No Winner"
                        : winner.toString(),
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 12.sp,
                      color: (winner == null || winner.toString().isEmpty)
                          ? Colors.red
                          : Colors.green,
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
