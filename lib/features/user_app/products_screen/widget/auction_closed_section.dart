
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/features/user_app/products_screen/presentation/product_bid_screen.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/live_action_details_model.dart';

class AuctionClosedSection extends StatelessWidget {
  final BidData? winningBit;
  final dynamic myId;
  final dynamic myShippingCost;
  final dynamic productPercentage;
  final dynamic stateName;

  const AuctionClosedSection({
    Key? key,
    this.winningBit,
    required this.myId,
    required this.myShippingCost,
    required this.productPercentage,
    required this.stateName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    UIHelper.verticalSpace(20),
                    Image.asset(
                      AppImages.doneIcon,
                      height: 45,
                      width: 45,
                    ),
                    Text(
                      'Auction Closed',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                   'This auction has officially ended',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    UIHelper.verticalSpace(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: winningBit== null?Column(
                              children: [

                                Icon(Icons.sentiment_dissatisfied_rounded,color: Colors.grey,weight: 20,size: 50,),
                                UIHelper.verticalSpace(10.h),
                                Text(
                                  'No bids were placed for this auction',
                                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ) :Column(
                              children: [
                                Text(
                                  'Winning Bid',
                                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                UIHelper.verticalSpace(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(

                                      child: Image.network(
                                        "$image_url${winningBit?.user?.avatar.toString()}",
                                        height: 45,
                                        width: 45,
                                        errorBuilder: (context, error, stackTrace) {
                                          // Return a fallback widget when the image fails to load
                                          return Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.grey[600],
                                              size: 24,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          winningBit?.user?.name ?? "",
                                          style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Winning Bidder',
                                          style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                UIHelper.verticalSpace(10),
                                UIHelper.verticalSpace(10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Final Price',
                                            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                              fontSize: 12.0.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '\$${winningBit?.amount.toString()}',
                                            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                              fontSize: 12.0.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(20),
                  ],
                ),
              ),
              UIHelper.verticalSpace(20),
              winningBit?.id != myId
                  ? SizedBox()
                  : CustomButton(
                onTap: () {
                  createConversationRx.createConversations(userId: winningBit?.user?.id);
                },
                text: "Contact to seller",
                context: context,
                minWidth: double.infinity,
              ),
              UIHelper.verticalSpace(20),
              winningBit?.user?.id == myId
                  ? PaymentDetails(
                product: winningBit!,
                myShippingCost: myShippingCost,
                productPercentage: productPercentage,
                stateName: stateName,
              )
                  : SizedBox(),
              UIHelper.verticalSpace(100)
            ],
          ),
        ),
      ),
    );
  }
}