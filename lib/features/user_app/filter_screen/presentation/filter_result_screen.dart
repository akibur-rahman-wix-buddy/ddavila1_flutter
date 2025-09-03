import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/complete_account_info_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/card_add_in_stripe.dart';
import 'package:ddavila/features/user_app/filter_screen/model/FilterProductDataModel.dart';
import 'package:ddavila/features/user_app/filter_screen/model/filter_fatch_data_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FilteredResultsScreen extends StatefulWidget {
  final FilterProductDataModel? filteredProducts;

  const FilteredResultsScreen({super.key, this.filteredProducts});

  @override
  State<FilteredResultsScreen> createState() => _FilteredResultsScreenState();
}

class _FilteredResultsScreenState extends State<FilteredResultsScreen> {
  bool isStripeConnected = appData.read(kKeyCardAttributes);
  bool isProfileConnected = appData.read(kKeyOnboarding);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Filtered Results'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildResultsBody(),
    );
  }

  Widget _buildResultsBody() {
    if (widget.filteredProducts == null ||
        widget.filteredProducts!.data == null ||
        widget.filteredProducts!.data!.data.isEmpty) {
      return const Center(child: Text('No products found matching your filters'));
    }

    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.7,
      ),
      itemCount: widget.filteredProducts!.data!.data!.length,
      itemBuilder: (context, index) {
        final product = widget.filteredProducts!.data!.data![index];
        return _buildProductItem(product);
      },
    );
  }
  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 120.h,
        color: Colors.white,
      ),
    );
  }






  Widget _buildProductItem( Product
  product) {
    return GestureDetector(


      onTap: (){
        print(">>>>>>>>>>>>>>>>> image url '$image_url${product.images[0]}'");
      },




      // onTap: () {
      //   print(">>>>>>>>>>>>>>> here is the product type  after ${product.type}");
      //   if (product.type.toString() == "sale") {
      //
      //
      //
      //     print(">>>>>>>>>>>>>>>>>>> here is the  stripe connected value ${isStripeConnected}");
      //     if(isStripeConnected == true && isProfileConnected == true){
      //
      //       NavigationService.navigateToWithArgs(
      //         Routes.productDetailsScreen,
      //         {"slug": product.slug,},
      //       );
      //     }else if(isStripeConnected == false ){
      //       Get.to(StripeCardScreen());
      //     }else if(isProfileConnected == false ){
      //       Get.to(CompleteAccountInfoScreen());
      //     }
      //
      //
      //     print(">>>>>>>>>>>>>>> here is the product id ${product.id}");
      //     print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
      //     // NavigationService.navigateToWithArgs(
      //     //   Routes.productDetailsScreen,
      //     //   {"slug": product.slug},
      //     // );
      //   }else if (product.type.toString() == "auction")  {
      //
      //     print(">>>>>>>>>>>>>>>>>>> this is the else product ");
      //
      //
      //     print(">>>>>>>>>>>>>>>>>>> here is the  stripe connected value ${isStripeConnected}");
      //     if(isStripeConnected == true && isProfileConnected == true){
      //
      //
      //
      //
      //       NavigationService.navigateToWithArgs(
      //         Routes.productsBidScreen,
      //         {"slag": product.slug, "productId": product.id},
      //       );
      //     }else if(isProfileConnected == false ){
      //       Get.to(CompleteAccountInfoScreen());
      //     }else if(isStripeConnected == false ){
      //       Get.to(StripeCardScreen());
      //     }
      //
      //     print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
      //     print(">>>>>>>>>>>>>>> here is the not sale , and this is id product id ${product.id}");
      //     // NavigationService.navigateToWithArgs(
      //     //   Routes.productsBidScreen,
      //     //   {"slag": product.slug, "productId": product..id},
      //     // );
      //   }
      // },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  height: 120.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    color: AppColor.cAEAEAE,
                  ),
                  child: product.images != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: Image.network(
                      '$image_url${product.images[0]}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.tshirtImage,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  )
                      : Image.asset(
                    AppImages.tshirtImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      // Handle favorite toggle
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        product.bookmark ?? false ? AppIcons.liveIcon : AppIcons.loveIcon,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? 'No Title',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    product.type?.toString().split('.').last ?? '',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c666666,
                      fontSize: 12.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c6940C9,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

















  // Widget _buildProductCard(FilterDatum product) {
  //   return Card(
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.r),
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.all(8.r),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Image with favorite button
  //           Stack(
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(8.r),
  //                 child: product.images != null && product.images!.isNotEmpty
  //                     ? Stack(
  //                   children: [
  //                     // Image with loading shimmer and error handling
  //                     Image.network(
  //                       product.images!.first,
  //                       width: double.infinity,
  //                       height: 120.h,
  //                       fit: BoxFit.cover,
  //                       loadingBuilder: (context, child, loadingProgress) {
  //                         if (loadingProgress == null) return child;
  //                         return _buildShimmerEffect();
  //                       },
  //                       frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
  //                         if (wasSynchronouslyLoaded) return child;
  //                         return AnimatedSwitcher(
  //                           duration: const Duration(milliseconds: 300),
  //                           child: frame != null ? child : _buildShimmerEffect(),
  //                         );
  //                       },
  //                       errorBuilder: (context, error, stackTrace) {
  //                         return Image.asset(
  //                           AppImages.placeholder,
  //                           width: double.infinity,
  //                           height: 120.h,
  //                           fit: BoxFit.cover,
  //                         );
  //                       },
  //                     ),
  //                     // Favorite button overlay
  //                     Positioned(
  //                       top: 8.h,
  //                       right: 8.w,
  //                       child: GestureDetector(
  //                         onTap: () => _toggleFavorite(product),
  //                         child: SvgPicture.asset(
  //                           product.bookmark ?? false
  //                               ? AppIcons.liveIcon
  //                               : AppIcons.loveIcon,
  //                           height: 24.h,
  //                           width: 24.w,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //                     : _buildShimmerEffect(),
  //               ),
  //               Positioned(
  //                 top: 8.h,
  //                 right: 8.w,
  //                 child: GestureDetector(
  //                   onTap: () => _toggleFavorite(product),
  //                   child: SvgPicture.asset(
  //                     product.bookmark ?? false
  //                         ? AppIcons.liveIcon
  //                         : AppIcons.loveIcon,
  //                     height: 24.h,
  //                     width: 24.w,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 8.h),
  //
  //           // Product title
  //           Text(
  //             product.title ?? 'No Title',
  //             style: TextStyle(
  //               fontSize: 14.sp,
  //               fontWeight: FontWeight.w600,
  //               color: AppColor.c000000,
  //             ),
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //           SizedBox(height: 4.h),
  //           //
  //           // // Location
  //           // Text(
  //           //   product. ?? 'Unknown Location', // Add location to your model if needed
  //           //   style: TextStyle(
  //           //     fontSize: 11.sp,
  //           //     fontWeight: FontWeight.w600,
  //           //     color: AppColor.c666666,
  //           //   ),
  //           // ),
  //           SizedBox(height: 8.h),
  //
  //           // Price and Value
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
  //                 style: TextStyle(
  //                   fontSize: 16.sp,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColor.c000000,
  //                 ),
  //               ),
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
  //                 decoration: BoxDecoration(
  //                   color: AppColor.c00B386,
  //                   borderRadius: BorderRadius.circular(4.r),
  //                 ),
  //                 child: Text(
  //                   'Value: ${product.price ?? 'N/A'}', // Add value to your model
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: AppColor.c666666,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 8.h),
  //
  //           // Pay Button
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               onPressed: () => _handlePay(product),
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: AppColor.allPrimaryColor,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8.r),
  //                 ),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //               ),
  //               child: Text(
  //                 'PAY NOW',
  //                 style: TextStyle(
  //                   fontSize: 14.sp,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void _toggleFavorite(FilterDatum product) {
  //   // Implement favorite toggle logic
  //   // You might want to call an API to update the bookmark status
  // }
  //
  // void _handlePay(FilterDatum product) {
  //   // Implement payment logic
  //   // NavigationService.navigateTo(Routes.paymentScreen, arguments: product);
  // }
}