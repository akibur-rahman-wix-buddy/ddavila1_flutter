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
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = -1;
  int? selectedPopularId;
  @override
  void initState() {
    getHomeCategoryRx.getHomeCategoryData();
    getPopularCategoryRx.getPopularCategoryData();
    liveAuctionDataRx.liveAuctionDataInfo();

    super.initState();
  }

  String formatDate(String isoDate) {
    // Parse the ISO date string into a DateTime object
    DateTime date = DateTime.parse(isoDate);

    // Format the DateTime object as MM/dd/yyyy
    String formattedDate = "${date.month}/${date.day}/${date.year}";

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // * Header section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Jhon',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Welcome to Shop',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 6),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFB0E8CA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.54),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 21,
                            height: 28,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.profileIcon),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // * Search TextField
                CustomTextField(
                  fieldWidth: double.infinity,
                  borderRadius: 58,
                  hintText: 'Search...',
                  prefixIcon: GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(
                        Routes.searchScreen,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        AppIcons.searchIcon,
                      ),
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.filterScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        AppIcons.filterIcon,
                      ),
                    ),
                  ),
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),

                // * Categories section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),


                ///>>>>>>>>>>>>>>>>>>>>>>>> here is the category section >>>>>>>>>>>>>>>>>>

                StreamBuilder<HomeCategoryApiDataModel>(
                  stream: getHomeCategoryRx.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          UIHelper.verticalSpace(10.h),
                          const Text(
                            "Loading...",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong!"));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data == null) {
                      return const Center(child: Text("No data found."));
                    } else {
                      final data = snapshot.data?.data;
                      return SizedBox(
                        height: 60, // Add a fixed height to the ListView
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              data?.length, // Replace with your data count
                          itemBuilder: (context, index) {
                            bool isSelected = selectedIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = isSelected
                                      ? -1
                                      : index; // Toggle selection
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Container(
                                    //   width: 53,
                                    //   height: 53,
                                    //   decoration: BoxDecoration(
                                    //     color: isSelected
                                    //         ? AppColor.c4275f6
                                    //         : Colors.white, // Background color
                                    //     borderRadius: BorderRadius.circular(30),
                                    //   ),
                                    //   child: ClipOval(
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(14.0),
                                    //       child: SvgPicture.asset(
                                    //         AppIcons.sportCard,
                                    //         color: isSelected
                                    //             ? Colors.white
                                    //             : Colors.black, // Icon color
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 8),

                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                            width: 1,
                                            color: isSelected
                                                ? AppColor.c4275f6
                                                : AppColor
                                                    .blackColor, // Text color
                                          )),
                                      child: Text(
                                        data?[index].title.toString() ?? "",
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          color: isSelected
                                              ? AppColor.c4275f6
                                              : AppColor
                                                  .blackColor, // Text color
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),

                // * ##################### Live Auction Text #####################
                // * ##################### Live Auction Item Card ################
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Live Auctions',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ///>>>>>>>>>>>>>>>>>>>>>>>> here is the live auction  section >>>>>>>>>>>>>>>>>>
                StreamBuilder<LiveAuctionApiDataModel>(
                  stream: liveAuctionDataRx.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          UIHelper.verticalSpace(10.h),
                          const Text(
                            "Loading...",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong!"));
                    } else if (!snapshot.hasData || snapshot.data?.data == null) {
                      return const Center(child: Text("No data found."));
                    } else {
                      return SizedBox(
                        height: 120.h,
                        width: double.infinity,
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = snapshot.data?.data;
                            return GestureDetector(

                              onTap: (){
                                NavigationService.navigateToWithArgs(Routes.productsBidScreen, {
                                  "slag":data[index].slug,
                                  "productId": data[index].id
                                });
                              },


                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: .4,
                                      blurRadius: .6
                                    )
                                  ]
                                ),
                                child: Center(
                                  // Centers everything inside the container
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: SizedBox(
                                            width: 90,
                                            child: Image.network(
                                              image_url + data![index].firstImage.toString(),
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child, loadingProgress) {
                                                // Show shimmer while loading
                                                if (loadingProgress == null) return child;
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor: Colors.grey[100]!,
                                                  child: Container(
                                                    width: 90,
                                                    height: 90, // Match your image height
                                                    color: Colors.white,
                                                  ),
                                                );
                                              },
                                              errorBuilder: (context, error, stackTrace) {
                                                // Fallback widget on error
                                                return Container(
                                                  width: 90,
                                                  height: 90,
                                                  color: Colors.grey[200],
                                                  child: const Icon(Icons.error_outline, color: Colors.red),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Vertically centers text in Column
                                        children: [
                                          SizedBox(
                                            width: 190.w,
                                            child: Text(
                                              data[index].title.toString()??"",
                                              style: TextFontStyle
                                                  .textLine7w400cFFFFFFDmSans
                                                  .copyWith(
                                                color: AppColor.c000000,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
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
                                              SizedBox(width: 8),
                                              Text(
                                                '\$${data[index].highestBid}',
                                                style: TextFontStyle
                                                    .textLine7w400cFFFFFFDmSans
                                                    .copyWith(
                                                  color: AppColor.c000000,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                '${data[index].bidsCount} bids',
                                                style: TextFontStyle
                                                    .textLine7w400cFFFFFFDmSans
                                                    .copyWith(
                                                  color: AppColor.cF15E17,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppIcons.timeIcon,
                                                width: 16,
                                                height: 16,
                                              ),
                                              SizedBox(width: 8),
                                              StreamBuilder<String>(
                                                stream: getLiveCountdownStream( isoTime:  data[index].auctionEndAt.toString()),
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    snapshot.data ?? "Loading...",
                                                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
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
                                      SizedBox(width: 15),
                                      SvgPicture.asset(
                                        AppIcons.arrowNext,
                                        width: 36,
                                        height: 36,
                                      ),
                                      SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),

                // * ##################### Popular Makes Text #####################
                SizedBox(height: 10),

                /// * ##################### Popular Makes Item Card ################
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Popular Makes',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),


            // Declare this at the top of your State class


              StreamBuilder<PopularCategoryDataModel>(
                stream: getPopularCategoryRx.dataFetcher,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong!"));
                  } else if (!snapshot.hasData || snapshot.data!.data == null) {
                    return const Center(child: Text("No data found."));
                  } else {
                    final data = snapshot.data!.data;

                    return SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final category = data![index];

                           selectedPopularId = data[0].id;
                           print(">>>>>>>>>>>>>>selected id ${selectedPopularId}");
                          categoryWiseProductRx.categoryWiseProductData(id:selectedPopularId);
                          final isSelected = selectedPopularId == category.id;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPopularId = category.id;
                                categoryWiseProductRx.categoryWiseProductData(id: selectedPopularId);
                                print("Selected popular category ID: ${category.id}");
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
                                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                        color: isSelected
                                            ? AppColor.c4275f6
                                            : AppColor.blackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),

            SizedBox(height: 10),


                StreamBuilder<CategoryWiseProductDataModel>(
                  stream: categoryWiseProductRx.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          UIHelper.verticalSpace(10.h),
                          const Text(
                            "Loading...",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong!"));
                    } else if (!snapshot.hasData || snapshot.data?.data == null) {
                      return const Center(child: Text("No data found."));
                    } else {
                      final data = snapshot.data?.data?.products?.data;


                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 10,
                          childAspectRatio: .5, // Adjust aspect ratio as needed
                        ),
                        itemCount: data?.length, // Replace with your data count
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(
                                Routes.productDetailsScreen,
                              );
                            },
                            child: Container
                              (
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 4
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center, // Center content
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Image Section
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            data?[index].images?.toString() ?? "", // Fallback to empty string if null
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 200,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                width: double.infinity,
                                                height: 200,
                                                color: Colors.grey[300], // Fallback background color
                                                child: const Icon(
                                                  Icons.broken_image, // Fallback icon
                                                  color: Colors.grey,
                                                  size: 50,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Product Title & Price
                                        Text(
                                          data?[index].title.toString()??"",
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
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
                                          data?[index].type.toString()??"",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // * Bid Info and Delivery
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${data?[index].price.toString()??""}',
                                              style: TextFontStyle
                                                  .textLine7w400cFFFFFFDmSans
                                                  .copyWith(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // Column(
                                            //   crossAxisAlignment:
                                            //   CrossAxisAlignment.start,
                                            //   children: [
                                            //     Text(
                                            //       'lostrav_6599.5%',
                                            //       style: TextStyle(
                                            //           fontSize: 12,
                                            //           color: Colors.grey),
                                            //     ),
                                            //     Text(
                                            //       'positive (595)',
                                            //       style: TextStyle(
                                            //           fontSize: 12,
                                            //           color: Colors.grey),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        // * Bid Status
                                        Row(
                                          children: [
                                            Text(
                                              '${data?[index].bid} bids',
                                              style: TextStyle(
                                                  fontSize: 10, color: Colors.red),
                                            ),
                                            UIHelper.horizontalSpace(12.h),
                                            Text(
                                              'Posted : ${formatDate(data?[index].createdAt.toString()??"")}',
                                              style: TextStyle(
                                                  fontSize: 10, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
























              ],
            ),
          ),
        ),
      ),
    );
  }
}
