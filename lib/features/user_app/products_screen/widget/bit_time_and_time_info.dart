// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/app_icons.dart';
// import 'package:ddavila/assets_helper/app_image.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
// import 'package:ddavila/common_widgets/time_decriment_counter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../model/live_action_details_model.dart';
//
//
//
// class PriceAndTimeInfo extends StatelessWidget {
//   final ProductData product;
//
//   const PriceAndTimeInfo({Key? key, required this.product}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColor.cF3F2F2),
//         borderRadius: BorderRadius.circular(12.0),
//         color: AppColor.cF3F2F2,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(13),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Starting Price',
//                   style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                     fontSize: 14.0,
//                     color: AppColor.c000000,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   '\$${product.startingPrice?.toString() ?? "0"}',
//                   style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                     fontSize: 12.0,
//                     color: AppColor.c000000,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.black,
//                           width: 2.0,
//                         ),
//                       ),
//                       child: ClipOval(
//                         child: Image.asset(
//                           AppImages.showImage,
//                           width: 20,
//                           height: 20,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8.0),
//                     Text(
//                       'are live',
//                       style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                         fontSize: 12.0,
//                         color: AppColor.c000000,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Current Bid Price',
//                   style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                     fontSize: 14.0,
//                     color: AppColor.c000000,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   '\$${product.highestBid?.toString() ?? "0"}',
//                   style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                     fontSize: 12.0,
//                     color: AppColor.c000000,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 Row(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                       ),
//                       child: ClipOval(
//                         child: SvgPicture.asset(
//                           AppIcons.blueTimer,
//                           width: 20,
//                           height: 20,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8.0),
//                     StreamBuilder<String>(
//                       stream: getLiveCountdownStream(isoTime: product.auctionEndAt.toString() ?? ""),
//                       builder: (context, snapshot) {
//                         return Text(
//                           snapshot.data ?? "Loading...",
//                           style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                             color: AppColor.c000000,
//                             fontSize: 10,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/time_decriment_counter.dart';

import '../model/live_action_details_model.dart';

class PriceAndTimeInfo extends StatelessWidget {
  final ProductData product;

  const PriceAndTimeInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? endTime = product.auctionEndAt.toString();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.cF3F2F2),
        borderRadius: BorderRadius.circular(12),
        color: AppColor.cF3F2F2,
      ),
      padding: const EdgeInsets.all(13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// ---------------- LEFT SIDE ----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Starting Price',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 14,
                  color: AppColor.c000000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.startingPrice ?? 0}',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 12,
                  color: AppColor.c000000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
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
                  const SizedBox(width: 8),
                  Text(
                    'are live',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 12,
                      color: AppColor.c000000,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),

          /// ---------------- RIGHT SIDE ----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Bid Price',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 14,
                  color: AppColor.c000000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.highestBid ?? 0}',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 12,
                  color: AppColor.c000000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.blueTimer,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),

                  /// -------- Countdown ----------
                  if (endTime == null || endTime.isEmpty)
                    const Text(
                      "Time not available",
                      style: TextStyle(fontSize: 10),
                    )
                  else
                    StreamBuilder<String>(
                      stream: getLiveCountdownStream(isoTime: endTime),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            "Loading...",
                            style: TextStyle(fontSize: 10),
                          );
                        }

                        if (!snapshot.hasData ||
                            snapshot.data == "Ended") {
                          return const Text(
                            "Auction Ended",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                            ),
                          );
                        }

                        return Text(
                          snapshot.data!,
                          style: TextFontStyle
                              .textLine7w400cFFFFFFDmSans
                              .copyWith(
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
    );
  }
}

