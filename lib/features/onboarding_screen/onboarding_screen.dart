// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, use_super_parameters

import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/auth_screen/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // * PageView for onboarding content
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                image:
                    AppImages.splashOne, // Replace with your image asset path
                title: '20% Discount \nNew Arrival Product',
                description:
                    'Publish up your selfies to make yourself more beautiful with this app.',
              ),
              OnboardingPage(
                image:
                    AppImages.splashTwo, // Replace with your image asset path
                title: 'Take Advantage Of The Offer Shopping ',
                description:
                    'Publish up your selfies to make yourself more beautiful with this app.',
              ),
              OnboardingPage(
                image:
                    AppImages.splashThree, // Replace with your image asset path
                title: 'All Types Offers \nWithin Your Reach',
                description:
                    'Publish up your selfies to make yourself more beautiful with this app.',
              ),
            ],
          ),
          // * Navigation Indicator and Button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3, // Updated to 3 dots as per the image
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: index == 0
                              ? 10
                              : 10, // First dot larger (24), others are smaller (10)
                          height: index == 0
                              ? 10
                              : 10, // Same as width for a perfect circle
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // * Button to navigate
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_currentPage == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        } else {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: SvgPicture.asset(
                        AppIcons.arrowRight,
                        height: 45,
                        width: 45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 50),
          Image.asset(image), // Image for the page
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
