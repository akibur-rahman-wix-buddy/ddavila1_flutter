// // ignore_for_file: deprecated_member_use

// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/app_icons.dart';
// import 'package:ddavila/assets_helper/app_image.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
// import 'package:ddavila/common_widgets/common_searchbar.dart';
// import 'package:ddavila/helpers/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class SearchUserScreen extends StatefulWidget {
//   const SearchUserScreen({super.key});

//   @override
//   State<SearchUserScreen> createState() => _SearchUserScreenState();
// }

// class _SearchUserScreenState extends State<SearchUserScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, String>> filteredServices = [];
//   final List<String> _previousSearches = [];

//   //ALL SEARVICES..
//   final List<Map<String, String>> _allServices = [
//     {
//       'name': 'Chameleon Parlour',
//       'location': '4.1 Km',
//       'price': '\$150',
//     },
//     {
//       'name': 'Beauty Lounge',
//       'location': '2.3 Km',
//       'price': '\$120',
//     },
//     {
//       'name': 'Pure Elegance Parlour',
//       'location': '5.0 Km',
//       'price': '\$50',
//     },
//     {
//       'name': 'Boulevard Parlour',
//       'location': '5.0 Km',
//       'price': '\$50',
//     },
//   ];

//   void _handleSearchBarClear() {
//     if (_searchController.text.isEmpty) {
//       setState(() {
//         filteredServices = [];
//       });
//     }
//   }

//   void _filterServices(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredServices = [];
//         return;
//       }

//       filteredServices = _allServices.where((service) {
//         return service['name']!.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }

//   void _onSearchSubmitted(String query) {
//     if (query.trim().isEmpty) return;

//     setState(() {
//       if (!_previousSearches.contains(query)) {
//         _previousSearches.add(query);
//       }
//       _filterServices(query);
//     });
//   }

//   void _removeSingleSearch(String search) {
//     setState(() {
//       _previousSearches.remove(search);
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_handleSearchBarClear);
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     filteredServices = [];
//     _searchController.addListener(_handleSearchBarClear);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(16.sp),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: SvgPicture.asset(
//                       AppIcons.arrowBack,
//                     ),
//                   ),
//                   UIHelper.horizontalSpace(10.w),
//                   Expanded(
//                     child: CommonSearchBar(
//                       controller: _searchController,
//                       onSubmitted: _onSearchSubmitted,
//                       hintText: 'Search for...',
//                       svgIcon: SvgPicture.asset(
//                         AppIcons.xcloseIcon,
//                         height: 14.h,
//                         width: 14.w,
//                         fit: BoxFit.cover,
//                       ),
//                       onTap: () {
//                         setState(() {
//                           _searchController.text = '';
//                           filteredServices = [];
//                         });
//                       },
//                     ),
//                   ),
//                   UIHelper.horizontalSpace(10.w),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _searchController.text = '';
//                         filteredServices = [];
//                       });
//                     },
//                     child: SvgPicture.asset(
//                       AppIcons.filterIcon,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               ),
//               UIHelper.verticalSpaceMedium,
//               Expanded(
//                 child: filteredServices.isEmpty &&
//                         _searchController.text.isEmpty
//                     ? Center(
//                         child: _previousSearches.isEmpty
//                             ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset(
//                                     AppIcons.searchIcon,
//                                     height: 81.h,
//                                     width: 82.w,
//                                   ),
//                                   Text(
//                                     'Sorry , In some cases, the error might be temporary.',
//                                     style: TextFontStyle
//                                         .textLine7w400cFFFFFFDmSans,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               )
//                             : Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Recents',
//                                         style: TextFontStyle
//                                             .textLine7w400cFFFFFFDmSans,
//                                       ),
//                                       GestureDetector(
//                                         child: Text(
//                                           'See All',
//                                           style: TextFontStyle
//                                               .textLine7w400cFFFFFFDmSans
//                                               .copyWith(
//                                             color: AppColor.blackColor,
//                                             fontSize: 16.sp,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   UIHelper.verticalSpaceSmall,
//                                   ListView.builder(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: _previousSearches.length,
//                                     itemBuilder: (context, index) {
//                                       final search = _previousSearches[index];
//                                       return Container(
//                                         decoration: BoxDecoration(),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Row(
//                                             children: [
//                                               SvgPicture.asset(
//                                                 AppIcons.clockIcon,
//                                               ),
//                                               UIHelper.horizontalSpace(10.w),
//                                               Text(
//                                                 search,
//                                                 style: TextFontStyle
//                                                     .textLine7w400cFFFFFFDmSans
//                                                     .copyWith(
//                                                   color: AppColor.blackColor,
//                                                   fontSize: 18.sp,
//                                                 ),
//                                               ),
//                                               const Spacer(),
//                                               GestureDetector(
//                                                 onTap: () =>
//                                                     _removeSingleSearch(search),
//                                                 child: SvgPicture.asset(
//                                                   AppIcons.xcloseIcon,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                       )
//                     : filteredServices.isEmpty
//                         ? Center(
//                             child: Text(
//                               'No results found',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           )
//                         : ListView.builder(
//                             physics: const BouncingScrollPhysics(),
//                             itemCount: filteredServices.length,
//                             itemBuilder: (context, index) {
//                               final service = filteredServices[index];
//                               return Container(
//                                 margin: EdgeInsets.only(bottom: 15.h),
//                                 decoration: BoxDecoration(
//                                   color: AppColor.cFFFFFF,
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   border: Border.all(
//                                     color: Colors.grey.withOpacity(0.5),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8.sp),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         height: 140,
//                                         width: 108,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(6.r),
//                                         ),
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.circular(
//                                               12.r), // Set the desired radius
//                                           child: Image.asset(
//                                             AppImages.appLogo,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       UIHelper.horizontalSpace(5.w),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Expanded(
//                                                   child: Text(
//                                                     service['name']!,
//                                                     style: TextFontStyle
//                                                         .textLine7w400cFFFFFFDmSans
//                                                         .copyWith(
//                                                       color: AppColor
//                                                           .allPrimaryColor,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SvgPicture.asset(
//                                                   AppIcons.arrowBack,
//                                                   height: 20.h,
//                                                   width: 20.w,
//                                                 ),
//                                                 Text("4.5"),
//                                               ],
//                                             ),
//                                             UIHelper.verticalSpace(10.h),
//                                             Row(
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                       AppIcons.doneIcon,
//                                                       color: AppColor.c6940C9,
//                                                     ),
//                                                     UIHelper.horizontalSpace(
//                                                         8.w),
//                                                     Text(
//                                                       service['location']!,
//                                                       style: TextFontStyle
//                                                           .textLine7w400cFFFFFFDmSans
//                                                           .copyWith(
//                                                         color: AppColor.c000000,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                             UIHelper.verticalSpace(30.h),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text.rich(
//                                                   TextSpan(
//                                                     children: [
//                                                       TextSpan(
//                                                         text:
//                                                             service['price'] ??
//                                                                 '',
//                                                         style: TextStyle(
//                                                           color:
//                                                               AppColor.c6940C9,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 18.0,
//                                                         ),
//                                                       ),
//                                                       TextSpan(
//                                                         text: '/hr',
//                                                         style: TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 14.0,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     // NavigationService
//                                                     //     .navigateTo(
//                                                     //   Routes.parlourServiceUser,
//                                                     // );
//                                                   },
//                                                   style:
//                                                       ElevatedButton.styleFrom(
//                                                     backgroundColor:
//                                                         AppColor.c6940C9,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               12.0),
//                                                     ),
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                       horizontal: 24.0,
//                                                       vertical: 12.0,
//                                                     ),
//                                                   ),
//                                                   child: Text(
//                                                     'Book Now',
//                                                     style: TextFontStyle
//                                                         .textLine7w400cFFFFFFDmSans
//                                                         .copyWith(
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations, avoid_unnecessary_containers

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/common_searchbar.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredServices = [];
  final List<String> _previousSearches = [];

  //ALL SERVICES..
  final List<Map<String, String>> _allServices = [
    {
      'name': 'Chameleon Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$150',
    },
    {
      'name': 'Beauty Lounge',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$120',
    },
    {
      'name': 'Pure Elegance Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$50',
    },
    {
      'name': 'Boulevard Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$50',
    },
    {
      'name': 'Boulevard Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$50',
    },
    {
      'name': 'Boulevard Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$50',
    },
    {
      'name': 'Boulevard Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$50',
    },
    {
      'name': 'Boulevard Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$50',
    },
    {
      'name': 'Boulevard Parlour',
      'location': 'Bubble Elastic T-shirt',
      'price': '\$50',
    },
  ];

  void _handleSearchBarClear() {
    if (_searchController.text.isEmpty) {
      setState(() {
        filteredServices = [];
      });
    }
  }

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredServices = [];
        return;
      }

      filteredServices = _allServices.where((service) {
        return service['name']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      if (!_previousSearches.contains(query)) {
        _previousSearches.add(query);
      }
      _filterServices(query);
    });
  }

  void _removeSingleSearch(String search) {
    setState(() {
      _previousSearches.remove(search);
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearchBarClear);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filteredServices = [];
    _searchController.addListener(_handleSearchBarClear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      AppIcons.arrowBack,
                    ),
                  ),
                  UIHelper.horizontalSpace(10.w),
                  Expanded(
                    child: CommonSearchBar(
                      controller: _searchController,
                      onSubmitted: _onSearchSubmitted,
                      hintText: 'Search for...',
                      svgIcon: SvgPicture.asset(
                        AppIcons.xcloseIcon,
                        height: 14.h,
                        width: 14.w,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          _searchController.text = '';
                          filteredServices = [];
                        });
                      },
                    ),
                  ),
                  UIHelper.horizontalSpace(10.w),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _searchController.text = '';
                  //       filteredServices = [];
                  //     });
                  //   },
                  //   child: SvgPicture.asset(
                  //     AppIcons.filterIcon,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                ],
              ),
              UIHelper.verticalSpaceMedium,
              Expanded(
                child: filteredServices.isEmpty &&
                        _searchController.text.isEmpty
                    ? Center(
                        child: _previousSearches.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.searchIcon,
                                    height: 81.h,
                                    width: 82.w,
                                  ),
                                  Text(
                                    'Sorry , In some cases, the error might be temporary.',
                                    style: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Recents',
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans,
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          'See All',
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
                                              .copyWith(
                                            color: AppColor.blackColor,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceSmall,
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _previousSearches.length,
                                    itemBuilder: (context, index) {
                                      final search = _previousSearches[index];
                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppIcons.clockIcon,
                                              ),
                                              UIHelper.horizontalSpace(10.w),
                                              Text(
                                                search,
                                                style: TextFontStyle
                                                    .textLine7w400cFFFFFFDmSans
                                                    .copyWith(
                                                  color: AppColor.c898282,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () =>
                                                    _removeSingleSearch(search),
                                                child: SvgPicture.asset(
                                                  AppIcons.xcloseIcon,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                      )
                    :
                    // filteredServices.isEmpty
                    //     ? Center(
                    //         child: Text(
                    //           'No results found',
                    //           style: TextStyle(
                    //             fontSize: 16.sp,
                    //             color: Colors.grey[700],
                    //           ),
                    //         ),
                    //       )
                    //     : GridView.builder(
                    //         physics: const BouncingScrollPhysics(),
                    //         gridDelegate:
                    //             SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 2,
                    //           crossAxisSpacing: 10.sp,
                    //           mainAxisSpacing: 15.sp,
                    //           childAspectRatio: 0.68,
                    //         ),
                    //         itemCount: filteredServices.length,
                    //         itemBuilder: (context, index) {
                    //           final service = filteredServices[index];
                    //           return Container(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 // * Stack to overlay the favorite button on the image
                    //                 Stack(
                    //                   children: [
                    //                     ClipRRect(
                    //                       borderRadius: BorderRadius.all(
                    //                         Radius.circular(10.r),
                    //                       ),
                    //                       child: Image.asset(
                    //                         AppImages.tshirtImage,
                    //                         width: double.infinity,
                    //                         fit: BoxFit.fill,
                    //                       ),
                    //                     ),
                    //                     // * Favorite button placed on top-right of the image
                    //                     Positioned(
                    //                       top: 8.h,
                    //                       right: 8.w,
                    //                       child: GestureDetector(
                    //                         onTap: () {},
                    //                         child: SvgPicture.asset(
                    //                           AppIcons.loveIcon,
                    //                           height: 24.h,
                    //                           width: 24.w,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 UIHelper.verticalSpace(5.h),
                    //                 Text(
                    //                   '${service['name']!}',
                    //                   style: TextFontStyle
                    //                       .textLine7w400cFFFFFFDmSans
                    //                       .copyWith(
                    //                     color: AppColor.c000000,
                    //                     fontSize: 14.sp,
                    //                     fontWeight: FontWeight.w600,
                    //                   ),
                    //                 ),
                    //                 UIHelper.verticalSpace(5.h),
                    //                 Text(
                    //                   '${service['location']!}',
                    //                   style: TextFontStyle
                    //                       .textLine7w400cFFFFFFDmSans
                    //                       .copyWith(
                    //                           color: AppColor.c666666,
                    //                           fontSize: 11.sp,
                    //                           fontWeight: FontWeight.w600),
                    //                 ),
                    //                 UIHelper.verticalSpace(5.h),
                    //                 Text(
                    //                   '${service['price']!}',
                    //                   style: TextFontStyle
                    //                       .textLine7w400cFFFFFFDmSans
                    //                       .copyWith(
                    //                     color: AppColor.c000000,
                    //                     fontSize: 16.sp,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //       ),
                    filteredServices.isEmpty
                        ? Center(
                            child: Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              // * Result text line at the top
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Result for "
                                      '"${_searchController.text}"',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.c000000,
                                      ),
                                    ),
                                    Text(
                                      '${filteredServices.length} Found',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.c000000,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // * GridView builder
                              Expanded(
                                child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.sp,
                                    mainAxisSpacing: 15.sp,
                                    childAspectRatio: 0.68,
                                  ),
                                  itemCount: filteredServices.length,
                                  itemBuilder: (context, index) {
                                    final service = filteredServices[index];
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // * Stack to overlay the favorite button on the image
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.r),
                                                ),
                                                child: Image.asset(
                                                  AppImages.tshirtImage,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              // * Favorite button placed on top-right of the image
                                              Positioned(
                                                top: 8.h,
                                                right: 8.w,
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: SvgPicture.asset(
                                                    AppIcons.loveIcon,
                                                    height: 24.h,
                                                    width: 24.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          UIHelper.verticalSpace(5.h),
                                          Text(
                                            '${service['name']!}',
                                            style: TextFontStyle
                                                .textLine7w400cFFFFFFDmSans
                                                .copyWith(
                                              color: AppColor.c000000,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          UIHelper.verticalSpace(5.h),
                                          Text(
                                            '${service['location']!}',
                                            style: TextFontStyle
                                                .textLine7w400cFFFFFFDmSans
                                                .copyWith(
                                              color: AppColor.c666666,
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          UIHelper.verticalSpace(5.h),
                                          Text(
                                            '${service['price']!}',
                                            style: TextFontStyle
                                                .textLine7w400cFFFFFFDmSans
                                                .copyWith(
                                              color: AppColor.c000000,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
