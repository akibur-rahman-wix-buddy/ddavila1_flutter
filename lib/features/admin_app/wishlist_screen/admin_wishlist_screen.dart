import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/features/admin_app/wishlist_screen/model/wishlist_model.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../assets_helper/text_font_style.dart';
import '../../../common_widgets/custom_appbar.dart';

class AdminWishListScreen extends StatefulWidget {
  const AdminWishListScreen({super.key});

  @override
  State<AdminWishListScreen> createState() => _AdminWishListScreenState();
}


class _AdminWishListScreenState extends State<AdminWishListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    getWishlistApiRxObj.getWishList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cFFFFFF,
      appBar: CustomAppBar(text: 'Wishlist'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(40.h),
              Text(
                'My Wish List',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                    .copyWith(
                  color: Color(0xff132235),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Keep an eye on the items you’re interest in, your watchlist let’s you track live auctions without placing a bid.',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                    .copyWith(
                    color: Color(0xff132235),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400
                ),
              ),
              UIHelper.verticalSpace(18.h),

              StreamBuilder<WishlistModel>(
                  stream: getWishlistApiRxObj.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data?.data == null) {
                      return const Center(child: Text('No data available.'));
                    }

                    final wishlist = snapshot.data!.data!;

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: wishlist.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {

                        final product = wishlist[index].product;
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
                                    product?.images?.isNotEmpty == true
                                        ? "$image_url${product!.images!.first}"
                                        : "", // Prevent crash when no image
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product?.title?? "",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),

                                          /// Button text depends on tab
                                          SvgPicture.asset(AppIcons.heart, height: 24.h, width: 24.w,),

                                        ],
                                      ),
                                      const SizedBox(height: 6),

                                      /// Current Bid
                                      Row(
                                        children: [
                                          const Text(
                                            "Your Bid  ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            product?.bid.toString()?? "",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      /// Time Left
                                      const Text(
                                        "O bids",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff161515),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        "From Unknown",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff161515),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),


            ],
          ),
        ),
      ),
    );
  }
}