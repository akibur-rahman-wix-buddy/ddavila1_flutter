// ignore_for_file: avoid_print, deprecated_member_use, unused_element, unused_field, camel_case_types, use_key_in_widget_constructors

import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';

class ProductsBidScreen extends StatefulWidget {
  const ProductsBidScreen({super.key});

  @override
  State<ProductsBidScreen> createState() => _ProductsBidScreenState();
}

class _ProductsBidScreenState extends State<ProductsBidScreen> {
  int? _selectedIndex;
  final List<String> items = ['17', '18', '19', '20', '21'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductImageSlider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
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
                          'Love of Soul Z500',
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
                            Text(
                              'Milinda Peterson',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                      fontSize: 16.0, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                                      '\$5,000',
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
                                      '\$5,000',
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
                                        Text(
                                          '01: 23s remaining',
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
                              '14 Bids made',
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
                        biddingPeopleList(),
                        biddingPeopleList(),
                        biddingPeopleList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildItem('\$120k', 0),
                  _buildItem('\$120k', 1),
                  _buildItem('\$120k', 2),
                  _buildItem('\$120k', 3),
                  _buildItem('use custom bid', 4),
                ],
              ),
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

  Widget _buildItem(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Update selected index
        });
      },
      child: Container(
        constraints: BoxConstraints(
            // Adjust width for longer text
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFF666666), // Replaced AppColor.c666666
            width: 2.0,
          ),
          color: isSelected ? AppColor.c000000 : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class biddingPeopleList extends StatelessWidget {
  const biddingPeopleList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15, // Half of the desired diameter (30/2)
            backgroundColor: Colors.black, // Border color
            child: CircleAvatar(
              radius: 13, // Slightly smaller to account for border thickness
              backgroundImage: AssetImage(AppImages.showImage),
            ),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Milinda Peterson',
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
            '\$24.5k',
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
      child: Container(
        height: 300.0,
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
              bottom: 20.0,
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
