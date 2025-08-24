// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/app_icons.dart';
// import 'package:ddavila/assets_helper/app_image.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
// import 'package:ddavila/common_widgets/custom_textfiled.dart';
// import 'package:ddavila/common_widgets/time_decriment_counter.dart';
// import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
// import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
// import 'package:ddavila/features/user_app/home_screen/model/live_autction_data_model.dart';
// import 'package:ddavila/features/user_app/home_screen/model/popular_category_data_model.dart';
// import 'package:ddavila/features/user_app/home_screen/widget/category_wise_card.dart';
// import 'package:ddavila/helpers/all_routes.dart';
// import 'package:ddavila/helpers/navigation_service.dart';
// import 'package:ddavila/helpers/ui_helpers.dart';
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:ddavila/networks/endpoints.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
//
//
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int selectedIndex = 0; // Default to 0th index
//   int? selectedPopularId;
//   bool isLoading = true; // Single loading state for initial data
//   bool isCategoryLoading = false; // Loading state for category-wise products
//
//   @override
//   void initState() {
//     super.initState();
//     _loadInitialData();
//   }
//
//   Future<void> _loadInitialData() async {
//     setState(() => isLoading = true);
//     await Future.wait([
//       getHomeCategoryRx.getHomeCategoryData(),
//       getPopularCategoryRx.getPopularCategoryData(),
//       liveAuctionDataRx.liveAuctionDataInfo(),
//     ]);
//     // Set initial category data fetch for 0th index
//     if (getHomeCategoryRx.dataFetcher.value.data?.isNotEmpty ?? false) {
//       final firstCategoryId = getHomeCategoryRx.dataFetcher.value.data![0].id;
//       await categoryWiseProductRx.categoryWiseProductData(id: firstCategoryId);
//     }
//     setState(() => isLoading = false);
//   }
//
//   String formatDate(String isoDate) {
//     try {
//       DateTime date = DateTime.parse(isoDate);
//       return "${date.month}/${date.day}/${date.year}";
//     } catch (e) {
//       return "Invalid date";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: isLoading
//             ? _buildLoadingIndicator()
//             : SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header section
//                 _buildHeader(),
//                 const SizedBox(height: 20),
//                 // Search TextField
//                 // _buildSearchField(),
//                 const SizedBox(height: 20),
//                 // Categories section
//                 _buildSectionTitle('Categories'),
//                 _buildCategoryList(),
//                 const SizedBox(height: 20),
//                 // Live Auctions section
//                 _buildSectionTitle('Live Auctions'),
//                 const SizedBox(height: 10),
//                 _buildLiveAuctions(),
//                 const SizedBox(height: 20),
//                 // Popular Makes section
//                 _buildSectionTitle('Popular Makes'),
//                 _buildPopularMakes(),
//                 const SizedBox(height: 10),
//                 // Category-wise products
//                 isCategoryLoading
//                     ? _buildLoadingIndicator()
//                     : _buildCategoryProducts(),
//                 const SizedBox(height: 80),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   ///>>>>>>>>>>>>>>>>>>>> here is the appbar section >>>>>>>>>>>>>>>>>>
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Hello Jhon',
//               style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Text(
//               'Welcome to Shop',
//               style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                 color: Colors.grey,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//         Container(
//           width: 41,
//           height: 41,
//           padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
//           decoration: ShapeDecoration(
//             color: const Color(0xFFB0E8CA),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.54),
//             ),
//           ),
//           child: Container(
//             width: 21,
//             height: 28,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(AppImages.profileIcon),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   ///>>>>>>>>>>>>>>>>>>>>> here is the search bar and filter>>>>>>>>>>>>>>>>>>>>>>>>>>>
//   Widget _buildSearchField() {
//     return CustomTextField(
//       fieldWidth: double.infinity,
//       borderRadius: 58,
//       hintText: 'Search...',
//       prefixIcon: GestureDetector(
//         onTap: () => NavigationService.navigateTo(Routes.searchScreen),
//         child: Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: SvgPicture.asset(AppIcons.searchIcon),
//         ),
//       ),
//       suffixIcon: GestureDetector(
//         onTap: () => NavigationService.navigateTo(Routes.filterScreen),
//         child: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: SvgPicture.asset(AppIcons.filterIcon),
//         ),
//       ),
//     );
//   }
//
//
//   ///>>>>>>>>>>>>>>>>>>>>>>> section title >>>>>>>>>>>>>>>>>>>>>>>>>
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//         color: Colors.black,
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
//
//
//   ///>>>>>>>>>>>>>> categories list >>>>>>>>>>>>>>>>>>>>>
//   Widget _buildCategoryList() {
//     return StreamBuilder<HomeCategoryApiDataModel>(
//       stream: getHomeCategoryRx.dataFetcher,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || snapshot.data!.data == null) {
//           return _buildErrorWidget("No data found.");
//         }
//
//         final data = snapshot.data?.data;
//         return SizedBox(
//           height: 60,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: data?.length,
//             itemBuilder: (context, index) {
//               bool isSelected = selectedIndex == index;
//               return GestureDetector(
//                 onTap: () async {
//                   setState(() {
//
//                     Get.to(
//                         CategoryProductsWidget(
//                           id: data?[index].id,
//                           screenName: data?[index].title,
//                         )
//                     );
//
//                     // selectedIndex = isSelected ? -1 : index;
//                     isCategoryLoading = true;
//
//                   });
//
//
//                   final categoryId = data?[index].id;
//                   if (categoryId != null) {
//                     await categoryWiseProductRx.categoryWiseProductData(id: categoryId);
//                   }
//                   setState(() => isCategoryLoading = false); // Hide loading after data fetch
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           border: Border.all(
//                             width: 1,
//                             color: isSelected ? AppColor.c4275f6 : AppColor.blackColor,
//                           ),
//                         ),
//                         child: Text(
//                           data?[index].title.toString() ?? "",
//                           style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                             color: isSelected ? AppColor.c4275f6 : AppColor.blackColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//
//   ///>>>>>>>>>>>>>>>>>>>>>>>>>> live action data >>>>>>>>>>>>>>>>>>>>>>>>>
//
//   Widget _buildLiveAuctions() {
//     return StreamBuilder<LiveAuctionApiDataModel>(
//       stream: liveAuctionDataRx.dataFetcher,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || (snapshot.data?.data?.isEmpty ?? true)) {
//           return _buildErrorWidget("No data found.");
//         }
//
//         return SizedBox(
//           height: 120.h,
//           width: double.infinity,
//           child: ListView.builder(
//             primary: false,
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: snapshot.data?.data?.length ?? 0,
//             itemBuilder: (context, index) {
//               final data = snapshot.data?.data?[index];
//               return GestureDetector(
//                 onTap: () => NavigationService.navigateToWithArgs(
//                   Routes.productsBidScreen,
//                   {"slag": data?.slug, "productId": data?.id},
//                 ),
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: const [
//                       BoxShadow(color: Colors.black12, spreadRadius: .4, blurRadius: .6)
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: SizedBox(
//                             width: 90,
//                             child: Image.network(
//                               image_url + (data?.firstImage.toString() ?? ""),
//                               fit: BoxFit.cover,
//                               loadingBuilder: (context, child, loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Container(width: 90, height: 90, color: Colors.white),
//                                 );
//                               },
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   width: 90,
//                                   height: 90,
//                                   color: Colors.grey[200],
//                                   child: const Icon(Icons.error_outline, color: Colors.red),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data?.title.toString() ?? "",
//                                 style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                                   color: AppColor.c000000,
//                                   fontSize: 12,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 5),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Current bid',
//                                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                                       color: AppColor.cF15E17,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     '\$${data?.highestBid}',
//                                     style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                                       color: AppColor.c000000,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 '${data?.bidsCount} bids',
//                                 style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                                   color: AppColor.cF15E17,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(AppIcons.timeIcon, width: 16, height: 16),
//                                   const SizedBox(width: 8),
//                                   StreamBuilder<String>(
//                                     stream: getLiveCountdownStream(isoTime: data?.auctionEndAt.toString() ?? ""),
//                                     builder: (context, snapshot) {
//                                       return Text(
//                                         snapshot.data ?? "Loading...",
//                                         style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                                           color: AppColor.c000000,
//                                           fontSize: 10,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         SvgPicture.asset(AppIcons.arrowNext, width: 36, height: 36),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//
//
//   ///>>>>>>>>>>>>>>>>>>>>>> popular categories data >>>>>>>>>>>>>>>>>>>>
//   Widget _buildPopularMakes() {
//     return StreamBuilder<PopularCategoryDataModel>(
//       stream: getPopularCategoryRx.dataFetcher,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || snapshot.data!.data == null) {
//           return _buildErrorWidget("No data found.");
//         }
//
//         final data = snapshot.data!.data;
//         selectedPopularId ??= data?.first.id;
//
//         return SizedBox(
//           height: 60,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: data?.length ?? 0,
//             itemBuilder: (context, index) {
//               final category = data![index];
//               final isSelected = selectedPopularId == category.id;
//
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedPopularId = category.id;
//                     isCategoryLoading = true; // Show loading when category changes
//                   });
//                   categoryWiseProductRx.categoryWiseProductData(id: selectedPopularId).then((_) {
//                     setState(() => isCategoryLoading = false); // Hide loading after data fetch
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           border: Border.all(
//                             width: 1,
//                             color: isSelected ? AppColor.allPrimaryColor : AppColor.buttonColor,
//                           ),
//                         ),
//                         child: Text(
//                           category.title.toString(),
//                           style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                             color: isSelected ? AppColor.c4275f6 : AppColor.blackColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//
//   ///>>>>>>>>>>>>>>>>>>>>>> product categories card >>>>>>>>>>>>>>>>>>>>
//
//   Widget _buildCategoryProducts() {
//     return StreamBuilder<CategoryWiseProductDataModel>(
//       stream: categoryWiseProductRx.dataFetcher,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || (snapshot.data?.data?.products?.data?.isEmpty ?? true)) {
//           return _buildErrorWidget("No data found.");
//         }
//
//         final data = snapshot.data?.data?.products?.data;
//         return GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 10,
//             childAspectRatio: .5,
//           ),
//           itemCount: data?.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//
//                 print(" here is the data ${data?[index].type}");
//
//                 if( data?[index].type.toString() == "sale"){
//                   NavigationService.navigateToWithArgs(
//                     Routes.productDetailsScreen,
//                     {"slug": data?[index].slug,});
//
//                 }else{
//                   NavigationService.navigateToWithArgs(
//                     Routes.productsBidScreen,
//                     {"slag": data?[index].slug, "productId": data?[index].id},
//                   );
//                 }
//
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.r),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 4)
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           data?[index].images?.toString() ?? "",
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 200,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: double.infinity,
//                               height: 200,
//                               color: Colors.grey[300],
//                               child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         data?[index].title.toString() ?? "",
//                         style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         data?[index].type.toString() ?? "",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.redAccent,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '\$${data?[index].price.toString() ?? ""}',
//                             style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
//                               fontSize: 18,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text(
//                             '${data?[index].bid} bids',
//                             style: const TextStyle(fontSize: 10, color: Colors.red),
//                           ),
//                           UIHelper.horizontalSpace(12.h),
//                           Text(
//                             'Posted : ${formatDate(data?[index].createdAt.toString() ?? "")}',
//                             style: const TextStyle(fontSize: 10, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//
//   ///>>>>>>>>>>>>> loading indicator >>>>>>>>>>>>>>>>>>>>>>>
//   Widget _buildLoadingIndicator() {
//     return const Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(color: Colors.blueAccent,),
//           SizedBox(height: 10),
//           Text("Loading...", style: TextStyle(color: Colors.blueAccent)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget(String message) {
//     return Center(child: Text(message,style: TextStyle(color: Colors.black),));
//   }
//
// }


































import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/common_widgets/time_decriment_counter.dart';
import 'package:ddavila/features/user_app/home_screen/model/category_wise_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/home_category_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/live_autction_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/model/popular_category_data_model.dart';
import 'package:ddavila/features/user_app/home_screen/widget/category_wise_card.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; // Default to 0th index
  int? selectedPopularId;
  bool isLoading = true; // Single loading state for initial data
  bool isCategoryLoading = false; // Loading state for category-wise products

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    print(">>>>>>>>>>>>>>> hello world");
  }

  Future<void> _loadInitialData() async {
    setState(() => isLoading = true);
    await Future.wait([
      getHomeCategoryRx.getHomeCategoryData(),
      getPopularCategoryRx.getPopularCategoryData(),
      liveAuctionDataRx.liveAuctionDataInfo(),
    ]);
    // Set initial category data fetch for 0th index
    if (getHomeCategoryRx.dataFetcher.value.data?.isNotEmpty ?? false) {
      final firstCategoryId = getHomeCategoryRx.dataFetcher.value.data![0].id;
      await categoryWiseProductRx.categoryWiseProductData(id: firstCategoryId);
    }
    setState(() => isLoading = false);
  }

  String formatDate(String isoDate) {
    try {
      DateTime date = DateTime.parse(isoDate);
      return "${date.month}/${date.day}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? _buildLoadingIndicator()
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                _buildHeader(),
                const SizedBox(height: 20),
                // Search TextField
                _buildSearchField(),
                const SizedBox(height: 20),
                // Categories section
                _buildSectionTitle('Categories'),
                _buildCategoryList(),
                const SizedBox(height: 20),
                // Live Auctions section
                _buildSectionTitle('Live Auctions'),
                const SizedBox(height: 10),
                _buildLiveAuctions(),
                const SizedBox(height: 20),
                // Popular Makes section
                _buildSectionTitle('Popular Makes'),
                _buildPopularMakes(),
                const SizedBox(height: 10),
                // Category-wise products
                isCategoryLoading
                    ? _buildLoadingIndicator()
                    : _buildCategoryProducts(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///>>>>>>>>>>>>>>>>>>>> here is the appbar section >>>>>>>>>>>>>>>>>>
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Jhon',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Welcome to Shop',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          width: 41,
          height: 41,
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: ShapeDecoration(
            color: const Color(0xFFB0E8CA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.54),
            ),
          ),
          child: Container(
            width: 21,
            height: 28,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.profileIcon),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>> here is the search bar and filter>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Widget _buildSearchField() {
    return CustomTextField(
      fieldWidth: double.infinity,
      borderRadius: 58,
      hintText: 'Search...',
      prefixIcon: GestureDetector(
        onTap: () => NavigationService.navigateTo(Routes.searchScreen),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(AppIcons.searchIcon),
        ),
      ),
      suffixIcon: GestureDetector(
        onTap: () => NavigationService.navigateTo(Routes.filterScreen),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(AppIcons.filterIcon),
        ),
      ),
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>> section title >>>>>>>>>>>>>>>>>>>>>>>>>
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  ///>>>>>>>>>>>>>> categories list >>>>>>>>>>>>>>>>>>>>>
  Widget _buildCategoryList() {
    return StreamBuilder<HomeCategoryApiDataModel>(
      stream: getHomeCategoryRx.dataFetcher,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.data == null) {
          return _buildErrorWidget("No data found.");
        }

        final data = snapshot.data?.data;
        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data?.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () async {
                  setState(() {
                    Get.to(CategoryProductsWidget(
                      id: data?[index].id,
                      screenName: data?[index].title,
                    ));

                    // selectedIndex = isSelected ? -1 : index;
                    isCategoryLoading = true;
                  });

                  final categoryId = data?[index].id;
                  if (categoryId != null) {
                    await categoryWiseProductRx
                        .categoryWiseProductData(id: categoryId);
                  }
                  setState(() => isCategoryLoading = false); // Hide loading after data fetch
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            width: 1,
                            color: isSelected
                                ? AppColor.c4275f6
                                : AppColor.blackColor,
                          ),
                        ),
                        child: Text(
                          data?[index].title.toString() ?? "",
                          style: TextFontStyle.textLine7w400cFFFFFFDmSans
                              .copyWith(
                            color: isSelected
                                ? AppColor.c4275f6
                                : AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>> live action data >>>>>>>>>>>>>>>>>>>>>>>>>

  Widget _buildLiveAuctions() {
    return StreamBuilder<LiveAuctionApiDataModel>(
      stream: liveAuctionDataRx.dataFetcher,
      builder: (context, snapshot) {
        if (!snapshot.hasData || (snapshot.data?.data?.isEmpty ?? true)) {
          return _buildErrorWidget("No data found.");
        }

        return SizedBox(
          height: 120.h,
          width: double.infinity,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final data = snapshot.data?.data?[index];
              return GestureDetector(
                onTap: () => NavigationService.navigateToWithArgs(
                  Routes.productsBidScreen,
                  {"slag": data?.slug, "productId": data?.id},
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85, // Added fixed width constraint
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: .4,
                          blurRadius: .6)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 90,
                            child: Image.network(
                              image_url + (data?.firstImage.toString() ?? ""),
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                      width: 90,
                                      height: 90,
                                      color: Colors.white),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.error_outline,
                                      color: Colors.red),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data?.title.toString() ?? "",
                                style: TextFontStyle
                                    .textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.c000000,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Current bid',
                                    style: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans
                                        .copyWith(
                                      color: AppColor.cF15E17,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '\$${data?.highestBid}',
                                    style: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans
                                        .copyWith(
                                      color: AppColor.c000000,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${data?.bidsCount} bids',
                                style: TextFontStyle
                                    .textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.cF15E17,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.timeIcon,
                                      width: 16, height: 16),
                                  const SizedBox(width: 8),
                                  StreamBuilder<String>(
                                    stream: getLiveCountdownStream(
                                        isoTime:
                                        data?.auctionEndAt.toString() ??
                                            ""),
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "Loading...",
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
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(AppIcons.arrowNext,
                            width: 36, height: 36),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>> popular categories data >>>>>>>>>>>>>>>>>>>>
  Widget _buildPopularMakes() {
    return StreamBuilder<PopularCategoryDataModel>(
      stream: getPopularCategoryRx.dataFetcher,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.data == null) {
          return _buildErrorWidget("No data found.");
        }

        final data = snapshot.data!.data;
        selectedPopularId ??= data?.first.id;

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              final category = data![index];
              final isSelected = selectedPopularId == category.id;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPopularId = category.id;
                    isCategoryLoading = true; // Show loading when category changes
                  });
                  categoryWiseProductRx
                      .categoryWiseProductData(id: selectedPopularId)
                      .then((_) {
                    setState(() => isCategoryLoading = false); // Hide loading after data fetch
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            width: 1,
                            color: isSelected
                                ? AppColor.allPrimaryColor
                                : AppColor.buttonColor,
                          ),
                        ),
                        child: Text(
                          category.title.toString(),
                          style: TextFontStyle.textLine7w400cFFFFFFDmSans
                              .copyWith(
                            color: isSelected
                                ? AppColor.c4275f6
                                : AppColor.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>> product categories card >>>>>>>>>>>>>>>>>>>>

  Widget _buildCategoryProducts() {
    return StreamBuilder<CategoryWiseProductDataModel>(
      stream: categoryWiseProductRx.dataFetcher,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            (snapshot.data?.data?.products?.data?.isEmpty ?? true)) {
          return _buildErrorWidget("No data found.");
        }

        final data = snapshot.data?.data?.products?.data;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            childAspectRatio: .5,
          ),
          itemCount: data?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(" here is the data ${data?[index].type}");

                if (data?[index].type.toString() == "sale") {
                  NavigationService.navigateToWithArgs(
                    Routes.productDetailsScreen,
                    {"slug": data?[index].slug},
                  );
                } else {
                  NavigationService.navigateToWithArgs(
                    Routes.productsBidScreen,
                    {"slag": data?[index].slug, "productId": data?[index].id},
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 4)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          data?[index].images?.toString() ?? "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image,
                                  color: Colors.grey, size: 50),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data?[index].title.toString() ?? "",
                        style: TextFontStyle.textLine7w400cFFFFFFDmSans
                            .copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data?[index].type.toString() ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${data?[index].price.toString() ?? ""}',
                            style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                .copyWith(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${data?[index].bid} bids',
                            style:
                            const TextStyle(fontSize: 10, color: Colors.red),
                          ),
                          UIHelper.horizontalSpace(12.h),
                          Text(
                            'Posted : ${formatDate(data?[index].createdAt.toString() ?? "")}',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  ///>>>>>>>>>>>>> loading indicator >>>>>>>>>>>>>>>>>>>>>>>
  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          SizedBox(height: 10),
          Text("Loading...", style: TextStyle(color: Colors.blueAccent)),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.black),
        ));
  }
}
