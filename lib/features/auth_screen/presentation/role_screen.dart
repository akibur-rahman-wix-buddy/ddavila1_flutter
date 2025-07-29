import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  // To track which container is selected
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 250),
                Image.asset(AppImages.appLogo, height: 100, width: 200),
                SizedBox(height: 230),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First Container wrapped in Expanded for equal width
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                          NavigationService.navigateTo(Routes.signInScreen);
                        },
                        child: Container(
                          height: 120,
                          margin: EdgeInsets.only(
                            right: 8,
                          ),
                          decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? Colors.blue
                                : Colors.white, // Blue if selected
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selectedIndex == 0
                                  ? Colors.blue
                                  : Colors.blue, // Blue border for both
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Join As Seller',
                                  style: TextFontStyle.buttonTextStyle.copyWith(
                                    color: selectedIndex == 0
                                        ? Colors.white
                                        : Colors
                                            .black, // White if selected, black if unselected
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Find shifts, track hours, \nand get paid on time.',
                                  style: TextFontStyle.buttonTextStyle.copyWith(
                                    color: selectedIndex == 0
                                        ? Colors.white
                                        : Colors
                                            .black, // White if selected, black if unselected
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Second Container wrapped in Expanded for equal width
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex =
                                1; // Mark the second container as selected
                          });
                          NavigationService.navigateTo(Routes.signInScreen);
                        },
                        child: Container(
                          height: 120,
                          margin: EdgeInsets.only(
                              left:
                                  8), // Add some spacing between the containers
                          decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? Colors.blue
                                : Colors.white, // Blue if selected
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selectedIndex == 1
                                  ? Colors.blue
                                  : Colors.blue, // Blue border for both
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Join As Buyer',
                                  style: TextFontStyle.buttonTextStyle.copyWith(
                                    color: selectedIndex == 1
                                        ? Colors.white
                                        : Colors
                                            .black, // White if selected, black if unselected
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Find shifts, track hours, \nand get paid on time.',
                                  style: TextFontStyle.buttonTextStyle.copyWith(
                                    color: selectedIndex == 1
                                        ? Colors.white
                                        : Colors
                                            .black, // White if selected, black if unselected
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
