




import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/admin_app/all_product/data/get_all_product_data/buying_order_rx.dart';
import 'package:ddavila/features/admin_app/all_product/model/all_product_data_model.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/complete_account_info_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/card_add_in_stripe.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';

class GetAllProductScreen extends StatefulWidget {
  const GetAllProductScreen({super.key});

  @override
  State<GetAllProductScreen> createState() => _GetAllProductScreenState();
}

class _GetAllProductScreenState extends State<GetAllProductScreen> {
  bool isStripeConnected = appData.read(kKeyCardAttributes);
  bool isProfileConnected = appData.read(kKeyOnboarding);
  late GetAllProductRX _getAllProductRX;
  AllProductDataModel? _products;
  List<AllProductData> _filteredProducts = [];
  bool _isLoading = true;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllProductRX = GetAllProductRX(
      empty: AllProductDataModel(
        success: false,
        message: "No data",
        data: ProductData(data: []),
        code: 0,
      ),
      dataFetcher: BehaviorSubject<AllProductDataModel>(),
    );
    _fetchProducts();
    _searchController.addListener(_filterProducts);
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final result = await _getAllProductRX.getBuyingOrderRX();
      if (result != null && result.success == true && result.data != null && result.data!.data.isNotEmpty) {
        setState(() {
          _products = result;
          _filteredProducts = result.data!.data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = result?.message ?? "Failed to load products";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "An error occurred: $e";
      });
    }
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products?.data?.data ?? [];
      } else {
        _filteredProducts = _products?.data?.data.where((product) {
          return product.title?.toLowerCase().contains(query) ?? false;
        }).toList() ?? [];
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _getAllProductRX.dataFetcher.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('All Products'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.r),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, size: 20.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColor.cAEAEAE),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              ),
            ),
          ),
          Expanded(child: _buildResultsBody()),
        ],
      ),
    );
  }

  Widget _buildResultsBody() {
    if (_isLoading) {
      return GridView.builder(
        padding: EdgeInsets.all(16.r),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => _buildShimmerEffect(),
      );
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_filteredProducts.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.7,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
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

  Widget _buildProductItem(AllProductData product) {
    return GestureDetector(
      onTap: () {
        print(">>>>>>>>>>>>>>> here is the product type after ${product.type}");
        if (product.type.toString() == "sale") {
          print(">>>>>>>>>>>>>>>>>>> here is the stripe connected value $isStripeConnected");
          if (isStripeConnected == true && isProfileConnected == true) {
            NavigationService.navigateToWithArgs(
              Routes.productDetailsScreen,
              {"slug": product.slug},
            );
          } else if (isStripeConnected == false) {
            Get.to(() => const StripeCardScreen());
          } else if (isProfileConnected == false) {
            Get.to(() => const CompleteAccountInfoScreen());
          }
          print(">>>>>>>>>>>>>>> here is the product id ${product.id}");
          print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
        } else if (product.type.toString() == "auction") {
          print(">>>>>>>>>>>>>>>>>>> this is the else product");
          print(">>>>>>>>>>>>>>>>>>> here is the stripe connected value $isStripeConnected");
          if (isStripeConnected == true && isProfileConnected == true) {
            NavigationService.navigateToWithArgs(
              Routes.productsBidScreen,
              {"slag": product.slug, "productId": product.id},
            );
          } else if (isProfileConnected == false) {
            Get.to(() => const CompleteAccountInfoScreen());
          } else if (isStripeConnected == false) {
            Get.to(() => const StripeCardScreen());
          }
          print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
          print(">>>>>>>>>>>>>>> here is the not sale, and this is id product id ${product.id}");
        }
      },
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
                  child: product.images != null && product.images!.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: Image.network(
                      '$image_url${product.images![0]}',
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
                    product.type?.toString() ?? '',
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
                  UIHelper.verticalSpace(8.h),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






