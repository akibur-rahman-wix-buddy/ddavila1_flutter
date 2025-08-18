import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/features/user_app/filter_screen/model/filter_fatch_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class FilteredResultsScreen extends StatefulWidget {
  final FilterProductDataModel? filteredProducts;

  const FilteredResultsScreen({super.key, this.filteredProducts});

  @override
  State<FilteredResultsScreen> createState() => _FilteredResultsScreenState();
}

class _FilteredResultsScreenState extends State<FilteredResultsScreen> {
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
        widget.filteredProducts!.data!.data == null ||
        widget.filteredProducts!.data!.data!.isEmpty) {
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
        return _buildProductCard(product);
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

  Widget _buildProductCard(FilterDatum product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with favorite button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: product.images != null && product.images!.isNotEmpty
                      ? Stack(
                    children: [
                      // Image with loading shimmer and error handling
                      Image.network(
                        product.images!.first,
                        width: double.infinity,
                        height: 120.h,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildShimmerEffect();
                        },
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) return child;
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: frame != null ? child : _buildShimmerEffect(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImages.placeholder,
                            width: double.infinity,
                            height: 120.h,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      // Favorite button overlay
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: GestureDetector(
                          onTap: () => _toggleFavorite(product),
                          child: SvgPicture.asset(
                            product.bookmark ?? false
                                ? AppIcons.liveIcon
                                : AppIcons.loveIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                    ],
                  )
                      : _buildShimmerEffect(),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(product),
                    child: SvgPicture.asset(
                      product.bookmark ?? false
                          ? AppIcons.liveIcon
                          : AppIcons.loveIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Product title
            Text(
              product.title ?? 'No Title',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.c000000,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            //
            // // Location
            // Text(
            //   product. ?? 'Unknown Location', // Add location to your model if needed
            //   style: TextStyle(
            //     fontSize: 11.sp,
            //     fontWeight: FontWeight.w600,
            //     color: AppColor.c666666,
            //   ),
            // ),
            SizedBox(height: 8.h),

            // Price and Value
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.c000000,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColor.c00B386,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    'Value: ${product.price ?? 'N/A'}', // Add value to your model
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.c666666,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handlePay(product),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.allPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                ),
                child: Text(
                  'PAY NOW',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite(FilterDatum product) {
    // Implement favorite toggle logic
    // You might want to call an API to update the bookmark status
  }

  void _handlePay(FilterDatum product) {
    // Implement payment logic
    // NavigationService.navigateTo(Routes.paymentScreen, arguments: product);
  }
}