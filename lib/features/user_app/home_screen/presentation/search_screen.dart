
import 'dart:async';
import 'dart:developer';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/common_searchbar.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/complete_account_info_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/card_add_in_stripe.dart';
import 'package:ddavila/features/user_app/home_screen/data/rx_search_result/rx.dart';
import 'package:ddavila/features/user_app/home_screen/model/product_search_data_model.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {

  bool isStripeConnected = appData.read(kKeyCardAttributes);
  bool isProfileConnected = appData.read(kKeyOnboarding);
  final TextEditingController _searchController = TextEditingController();
  final List<String> _previousSearches = [];
  final _debouncer = Debouncer(milliseconds: 500);

  ProductSearchApiDataModel? _searchResults;
  bool _isLoading = false;
  bool _hasSearched = false;
  String _currentQuery = '';
  String? _errorMessage;

  final SearchResultRx _searchRx = SearchResultRx(
    empty: ProductSearchApiDataModel(),
    dataFetcher: BehaviorSubject<ProductSearchApiDataModel>(),
  );

  StreamSubscription<ProductSearchApiDataModel>? _searchSubscription;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearchChange);

    // Listen to RX stream
    _searchSubscription = _searchRx.getFileData.listen(
          (data) {
        if (mounted) {
          setState(() {
            _searchResults = data;
            _isLoading = false;
            _errorMessage = null;
          });
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _searchResults = null;
            _errorMessage = error.toString();
          });
        }
      },
    );
  }

  void _handleSearchChange() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults = null;
        _hasSearched = false;
        _currentQuery = '';
        _errorMessage = null;
      });
      return;
    }

    // Debounce the search to avoid too many API calls
    _debouncer.run(() {
      if (_searchController.text.isNotEmpty && _searchController.text != _currentQuery) {
        _performSearch(_searchController.text);
      }
    });
  }

// Update your screen's _performSearch method
  void _performSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _currentQuery = query;
      _errorMessage = null;
    });

    try {
      // Use RX to call API with timeout
      await _searchRx.searchResultApiInfo(query: query, result: "")
          .timeout(const Duration(seconds: 45), onTimeout: () {
        throw TimeoutException('Search took too long');
      });

      // Add to previous searches if not already there
      if (!_previousSearches.contains(query)) {
        setState(() {
          _previousSearches.add(query);
        });
      }
    } on TimeoutException {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Search took too long. Please try again.';
      });
    } catch (error) {
      log('Search error in UI: $error');
      setState(() {
        _isLoading = false;
        // Provide more user-friendly error messages
        if (error.toString().contains('Timeout') || error.toString().contains('timed out')) {
          _errorMessage = 'Search took too long. Please try again.';
        } else if (error.toString().contains('JSON') || error.toString().contains('parse')) {
          _errorMessage = 'Could not process search results. Please try again.';
        } else {
          _errorMessage = error.toString();
        }
      });
    }
  }

  void _onSearchSubmitted(String query) {
    // Clear any pending debounced searches
    _debouncer.cancel();
    _performSearch(query);
  }

  void _clearSearch() {
    setState(() {
      _searchController.text = '';
      _searchResults = null;
      _hasSearched = false;
      _currentQuery = '';
      _errorMessage = null;
    });
  }

  void _searchFromHistory(String search) {
    _searchController.text = search;
    _performSearch(search);
  }

  void _removeSingleSearch(String search) {
    setState(() {
      _previousSearches.remove(search);
    });
  }

  void _clearSearchHistory() {
    setState(() {
      _previousSearches.clear();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearchChange);
    _searchController.dispose();
    _debouncer.dispose();
    _searchSubscription?.cancel();
    _searchRx.dataFetcher.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              // Search Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      AppIcons.arrowBack,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  UIHelper.horizontalSpace(10.w),
                  Expanded(
                    child: CommonSearchBar(
                      controller: _searchController,
                      onSubmitted: _onSearchSubmitted,
                      hintText: 'Search for products...',
                      svgIcon: SvgPicture.asset(
                        AppIcons.xcloseIcon,
                        height: 14.h,
                        width: 14.w,
                        fit: BoxFit.cover,
                      ),
                      onTap: _clearSearch,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium,

              // Main Content
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return _buildLoading();
    }

    if (_errorMessage != null) {
      return _buildError();
    }

    if (_searchResults != null) {
      return _buildSearchResults();
    }

    if (_hasSearched) {
      return _buildNoResults();
    }

    return _buildInitialState();
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.c6940C9),
          ),
          UIHelper.verticalSpace(16.h),
          Text(
            'Searching for "$_currentQuery"...',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              color: AppColor.c000000,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.voucherCard,
            height: 64.h,
            width: 64.w,
          ),
          UIHelper.verticalSpace(16.h),
          Text(
            'Search Failed',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              color: AppColor.c000000,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            _errorMessage ?? 'Unknown error occurred',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              color: AppColor.c666666,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpace(16.h),
          ElevatedButton(
            onPressed: () => _performSearch(_currentQuery),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.c6940C9,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final products = _searchResults!.data?.data ?? [];
    final totalResults = _searchResults!.data?.total ?? 0;

    if (products.isEmpty) {
      return _buildNoResults();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results Header
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Results for \"$_currentQuery\"",
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.c000000,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              UIHelper.horizontalSpace(8.w),
              Text(
                '$totalResults Found',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.c666666,
                ),
              ),
            ],
          ),
        ),

        // Products Grid
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(

                  onTap: () {
                    print(">>>>>>>>>>>>>>> here is the product type  after ${product.type}");
                    if (product.type.toString() == "sale") {



                      print(">>>>>>>>>>>>>>>>>>> here is the  stripe connected value ${isStripeConnected}");
                      if(isStripeConnected == true|| isProfileConnected == true){

                        NavigationService.navigateToWithArgs(
                          Routes.productDetailsScreen,
                          {"slug": product.slug,},
                        );
                      }else if(isStripeConnected == false ){
                        Get.to(StripeCardScreen());
                      }else if(isProfileConnected == false ){
                        Get.to(CompleteAccountInfoScreen());
                      }


                      print(">>>>>>>>>>>>>>> here is the product id ${product.id}");
                      print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
                      // NavigationService.navigateToWithArgs(
                      //   Routes.productDetailsScreen,
                      //   {"slug": product.slug},
                      // );
                    } else {





                      print(">>>>>>>>>>>>>>>>>>> here is the  stripe connected value ${isStripeConnected}");
                      if(isStripeConnected == true|| isProfileConnected == true){

                        NavigationService.navigateToWithArgs(
                          Routes.productsBidScreen,
                          {"slag": product.slug, "productId": product.id},
                        );
                      }else if(isProfileConnected == false ){
                        Get.to(CompleteAccountInfoScreen());
                      }else if(isProfileConnected == false ){
                        Get.to(StripeCardScreen());
                      }














                      print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
                      print(">>>>>>>>>>>>>>> here is the not sale , and this is id product id ${product.id}");
                      // NavigationService.navigateToWithArgs(
                      //   Routes.productsBidScreen,
                      //   {"slag": product.slug, "productId": product..id},
                      // );
                    }
                  },

                  child: _buildProductItem(product));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(SearchProductData
  product) {
    return Container(
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
                child: product.firstImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: Image.network(
                    'https://your-base-url.com/${product.firstImage}',
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
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.searchIcon,
            height: 81.h,
            width: 82.w,
          ),
          UIHelper.verticalSpace(16.h),
          Text(
            'No results found for "$_currentQuery"',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              color: AppColor.c000000,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            'Try different keywords or check your spelling',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              color: AppColor.c666666,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_previousSearches.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  color: AppColor.c000000,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: _clearSearchHistory,
                child: Text(
                  'Clear All',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    color: AppColor.c6940C9,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _previousSearches.length,
              itemBuilder: (context, index) {
                final search = _previousSearches[index];
                return ListTile(
                  leading: SvgPicture.asset(
                    AppIcons.clockIcon,
                    height: 20.h,
                    width: 20.w,
                  ),
                  title: Text(
                    search,
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () => _removeSingleSearch(search),
                    child: SvgPicture.asset(
                      AppIcons.xcloseIcon,
                      height: 16.h,
                      width: 16.w,
                    ),
                  ),
                  onTap: () => _searchFromHistory(search),
                );
              },
            ),
          ),
        ] else ...[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.searchIcon,
                    height: 81.h,
                    width: 82.w,
                  ),
                  UIHelper.verticalSpace(16.h),
                  Text(
                    'Search for products',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    'Find your favorite items by typing in the search bar above',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c666666,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }

  void dispose() {
    cancel();
  }
}