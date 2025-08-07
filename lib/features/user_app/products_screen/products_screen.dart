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
  int _counter = 1; // Initial value of the counter
  int? _selectedIndex; // Tracks the selected size index
  final List<String> items = ['17', '18', '19', '20', '21'];
  int? _selectedColorIndex;
  // Sample color data (replace with your actual colors)
  final List<Color> colors = [
    AppColor.c6940C9,
    Colors.red,
    Colors.blue,
    Colors.green,
  ]; // Size data

  void _incrementCounter() {
    setState(() {
      _counter++; // Increment the counter
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--; // Decrement the counter
      }
    });
  }

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
                            // Quantity
                            Container(
                              height: 40,
                              width: 100,
                              margin: EdgeInsets.only(left: 20.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: AppColor.cEDEDED,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: _decrementCounter,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                      size: 18.0,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    '$_counter',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  GestureDetector(
                                    onTap: _incrementCounter,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Size Selection
                        Text('Size', style: TextStyle(fontSize: 16.0)),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Size Selection ListView
                            Expanded(
                              child: SizedBox(
                                height:
                                    50.0, // Constrain the height of ListView
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    bool isSelected = _selectedIndex == index;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex =
                                              index; // Update selection
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        padding: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColor.c6940C9
                                              : Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          border: Border.all(
                                              color: AppColor.c6940C9),
                                        ),
                                        child: Text(
                                          items[index],
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : AppColor.c6940C9,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Additional Icon
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Handle icon tap (e.g., open filter)
                                  print('Filter icon tapped');
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.c6940C9,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            // Additional Container
                            Container(
                              margin: EdgeInsets.only(right: 8.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: AppColor.whiteColor),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 9.0,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: List.generate(
                                  colors.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedColorIndex =
                                            index; // Update selected color
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      width: 25.0,
                                      height: 25.0,
                                      decoration: BoxDecoration(
                                        color: colors[index],
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _selectedColorIndex == index
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: _selectedColorIndex == index
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15.0,
                                            )
                                          : null, // Show checkmark only for selected
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.0),
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
