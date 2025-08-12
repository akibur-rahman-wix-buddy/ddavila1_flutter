// ignore_for_file: avoid_print, deprecated_member_use, unused_element, unused_field, camel_case_types, use_key_in_widget_constructors

import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/common_widgets/time_decriment_counter.dart';
import 'package:ddavila/features/user_app/products_screen/model/live_action_details_model.dart';
import 'package:ddavila/helpers/html_text_viewer.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:shimmer/shimmer.dart';

class ProductsBidScreen extends StatefulWidget {
  final dynamic slag;
  const ProductsBidScreen({super.key, required this.slag});

  @override
  State<ProductsBidScreen> createState() => _ProductsBidScreenState();
}

class _ProductsBidScreenState extends State<ProductsBidScreen> {

  @override
  void initState() {
    liveAuctionDetailsDataRx.liveAuctionDetailsDataInfo(slug: widget.slag);
    print("here is the slug: ${widget.slag}");
    super.initState();
  }





  int? _selectedIndex;
  // final List<String> items = ['17', '18', '19', '20', '21'];

  @override
  Widget build(BuildContext context) {

    TextEditingController priceController = TextEditingController();


    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: StreamBuilder<LiveAuctionDetailsApiDataModel>(
          stream: liveAuctionDetailsDataRx.dataFetcher,
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


              setState(() {

                priceController = (snapshot.data?.data?.highestBid.toString()??"") as TextEditingController ;
              });


              final data = snapshot.data?.data;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageSlider(
                      images:data?.images??[],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        // height: 100,
                        decoration: const BoxDecoration(
                          color: AppColor.blackColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data?.title.toString()??"",
                                style:
                                TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(Icons.person,

                                      color: Colors.white70, size: 16.0),



                                  // Text(
                                  //   'Milinda Peterson',
                                  //   style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  //       .copyWith(
                                  //       fontSize: 16.0, color: Colors.white70),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HtmlToWidgetRenderer(
                        htmlData: data?.description.toString()??"",
                        glassIntensity: 0.3,
                        glassTintColor: Colors.blue.withOpacity(0.1),
                        defaultTextStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    UIHelper.verticalSpace(16.h),

                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.cDCE4E6,
                            blurRadius: 9.9,
                            offset: Offset(0, 0.1),
                          ),
                        ],
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.cF3F2F2),
                                borderRadius: BorderRadius.circular(12.0),
                                color: AppColor.cF3F2F2,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  13,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Starting Price',
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
                                              .copyWith(
                                            fontSize: 14.0,
                                            color: AppColor.c000000,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '\$${ data?.startingPrice
                                              .toString() ?? ""}',
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
                                              .copyWith(
                                            fontSize: 12.0,
                                            color: AppColor.c000000,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width:
                                                  2.0, // Adjust border thickness as needed
                                                ),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  AppImages.showImage,
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit
                                                      .cover, // Ensures the image fills the circular area
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              'are live',
                                              style: TextFontStyle
                                                  .textLine7w400cFFFFFFDmSans
                                                  .copyWith(
                                                fontSize: 12.0,
                                                color: AppColor.c000000,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Current Bid Price',
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
                                              .copyWith(
                                            fontSize: 14.0,
                                            color: AppColor.c000000,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '\$${data?.highestBid.toString()??""}',
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
                                              .copyWith(
                                            fontSize: 12.0,
                                            color: AppColor.c000000,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipOval(
                                                child: SvgPicture.asset(
                                                  AppIcons.blueTimer,
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit
                                                      .cover, // Ensures the image fills the circular area
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.0),
                                            StreamBuilder<String>(
                                              stream: getLiveCountdownStream( isoTime: data?.auctionEndAt.toString()??""),
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
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Live Auction',
                                  style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0,
                                    color: AppColor.c000000,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${data?.bid.toString()??""} Bids made',
                                  style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 12.0,
                                    color: AppColor.c000000,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: data?.bids?.length,

                                itemBuilder: (context, index) {
                                return    biddingPeopleList(
                                  image: data?.bids?[index].user?.avatar.toString() ??"",
                                  name:  data?.bids?[index].user?.name.toString() ??"",
                                  value:  data?.bids?[index].amount.toString() ??"",                               );
                              },),
                            )


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),

      ),
      floatingActionButton: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
        ),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:CustomTextField(
                controller: priceController,
              )
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomButton(
                minWidth: double.infinity,
                text: 'Place Bid',
                context: context,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Widget _buildItem(String text, int index) {
  //   bool isSelected = _selectedIndex == index;
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         _selectedIndex = index; // Update selected index
  //       });
  //     },
  //     child: Container(
  //       constraints: BoxConstraints(
  //           // Adjust width for longer text
  //           ),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(
  //           color: Color(0xFF666666), // Replaced AppColor.c666666
  //           width: 2.0,
  //         ),
  //         color: isSelected ? AppColor.c000000 : Colors.transparent,
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Text(
  //           text,
  //           style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
  //             color: isSelected ? Colors.white : Colors.black,
  //             fontSize: 14,
  //             overflow: TextOverflow.ellipsis,
  //             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class biddingPeopleList extends StatelessWidget {

  final String image;
  final String name;
  final String value;

  const biddingPeopleList({
    super.key, required this.image, required this.name, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                height: 40,
                width: 40,
                image_url + image.toString() ?? "",
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  // Show shimmer while loading
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  // Fallback widget on error
                  return Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error_outline, color: Colors.red),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 14.0,
                  color: AppColor.c000000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Bidder',
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 12.0,
                  color: AppColor.c000000,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '\$${value}',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              fontSize: 14.0,
              color: AppColor.c000000,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImageSlider extends StatefulWidget {
  final List<String> images;

  const ProductImageSlider({Key? key, required this.images}) : super(key: key);

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}
class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount:  widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {

              return Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image_url + widget.images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      // Show shimmer while loading
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
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
              );




              // return ClipRRect(
              //   borderRadius: BorderRadius.circular(10.0),
              //   child: Image.asset(
              //    image_url+widget.images[index],
              //     fit: BoxFit.cover,
              //   ),
              // );
            },
          ),
          Positioned(
            top: 10.0,
            left: 16.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(AppIcons.arrowBack),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 16.0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 9.9,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AppIcons.cartIcon,
                  height: 44.0,
                  width: 44.0,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  widget.images.length,
                (index) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.5,
                      color: _currentIndex == index
                          ? Colors.red
                          : Colors.transparent,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      height: _currentIndex == index ? 10.0 : 6.0,
                      width: _currentIndex == index ? 10.0 : 6.0,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeButton extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback onTap; // Add callback for tap handling

  const SizeButton({
    required this.size,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the provided callback
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.c6940C9 : Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColor.c6940C9),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColor.c6940C9,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
