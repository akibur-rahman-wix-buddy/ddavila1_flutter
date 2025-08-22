// ignore_for_file: avoid_print, deprecated_member_use

import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<String> items = ['17', '18', '19', '20', '21'];

  // Sample color data (replace with your actual colors)
  final List<Color> colors = [
    AppColor.c6940C9,
    Colors.red,
    Colors.blue,
    Colors.green,
  ]; // Size data



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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                          ],
                        ),
                        SizedBox(height: 16.0),
                        // Availability
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
                        // Description
                        Text(
                          'Engineered to crush any movement-based workout, these On sneakers enhance the label\'s original Cloud sneaker with cutting-edge technologies for a pair.',
                          style: TextFontStyle.textLine7w400cFFFFFFDmSans
                              .copyWith(
                                  fontSize: 12.0,
                                  color: Colors.black.withOpacity(0.7)),
                        ),
                        SizedBox(height: 16.0),
                        // Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Price:',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '\$245.00',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            CustomButton(
                              text: 'Buy Now',
                              context: context,
                              minWidth: 200,
                            ),
                          ],
                        ),
                        // Buy Now Button
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
