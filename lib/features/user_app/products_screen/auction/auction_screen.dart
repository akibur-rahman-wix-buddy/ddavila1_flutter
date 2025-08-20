// ignore_for_file: unused_field, deprecated_member_use, unused_element

import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductAuctionScreen extends StatefulWidget {
  const ProductAuctionScreen({super.key});

  @override
  State<ProductAuctionScreen> createState() => _ProductAuctionScreenState();
}

class _ProductAuctionScreenState extends State<ProductAuctionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductImageSlider(),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name and Rating
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
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
                                        UIHelper.verticalSpace(
                                          20,
                                        ),
                                        Image.asset(
                                          AppImages.doneIcon,
                                          height: 45,
                                          width: 45,
                                        ),
                                        Text(
                                          'Auction Closed',
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
                                              .copyWith(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'This auction has officially ended',
                                          style: TextFontStyle
                                              .textLine7w400cFFFFFFDmSans
                                              .copyWith(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        UIHelper.verticalSpace(
                                          10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Winning Bid',
                                                      style: TextFontStyle
                                                          .textLine7w400cFFFFFFDmSans
                                                          .copyWith(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    UIHelper.verticalSpace(
                                                      10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          AppImages.profile,
                                                          height: 40,
                                                          width: 40,
                                                        ),
                                                        UIHelper
                                                            .horizontalSpace(
                                                          10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Jhon Doe',
                                                              style: TextFontStyle
                                                                  .textLine7w400cFFFFFFDmSans
                                                                  .copyWith(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Winning Bidder',
                                                              style: TextFontStyle
                                                                  .textLine7w400cFFFFFFDmSans
                                                                  .copyWith(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    UIHelper.verticalSpace(
                                                      10,
                                                    ),
                                                    UIHelper.verticalSpace(
                                                      10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green
                                                              .withOpacity(
                                                            0.1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'Axel Arigato',
                                                                style: TextFontStyle
                                                                    .textLine7w400cFFFFFFDmSans
                                                                    .copyWith(
                                                                  fontSize:
                                                                      12.0.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                '\$100166.00',
                                                                style: TextFontStyle
                                                                    .textLine7w400cFFFFFFDmSans
                                                                    .copyWith(
                                                                  fontSize:
                                                                      12.0.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        UIHelper.verticalSpace(
                                          20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  UIHelper.verticalSpace(
                                    20,
                                  ),
                                  Text(
                                    'Axel Arigato',
                                    style: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans
                                        .copyWith(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'FREE SHIPPING! FREE RETURNS! View Store For Coupons!',
                                    style: TextFontStyle
                                        .textLine7w400cFFFFFFDmSans
                                        .copyWith(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                  ),
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18.0),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18.0),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18.0),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 18.0),
                                      Icon(Icons.star_border,
                                          color: Colors.yellow, size: 18.0),
                                      SizedBox(width: 5.0),
                                      Text(
                                        '(270 Review)',
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Description',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Engineered to crush any movement-based workout, these On sneakers enhance the label\'s original Cloud sneaker with cutting-edge technologies for a pair.',
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            fontSize: 12.0,
                            color: Colors.black.withOpacity(
                              0.7,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(
                          20,
                        ),
                        // * Pricing List
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price:- ',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$245.00',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(
                              10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax:- ',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$245.00',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(
                              10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Price:- ',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$245.00',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.5),
                              thickness: 1.0,
                            ),
                            UIHelper.verticalSpace(
                              10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price:- ',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$245.00',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(
                          20,
                        ),
                        CustomButton(
                          minWidth: double.infinity,
                          text: 'Proceed To Payment',
                          context: context,
                        ),
                        
                        UIHelper.verticalSpace(100)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductImageSlider extends StatefulWidget {
  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;
  final List<String> _images = [
    AppImages.showImage,
    AppImages.showImage,
    AppImages.showImage,
  ];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  _images[index],
                  fit: BoxFit.cover,
                ),
              );
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
            bottom: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _images.length,
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
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
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
