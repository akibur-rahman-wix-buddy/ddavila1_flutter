import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = -1;

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
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(
                      AppIcons.searchIcon,
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
                SizedBox(
                  height: 130, // Add a fixed height to the ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10, // Replace with your data count
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex =
                                isSelected ? -1 : index; // Toggle selection
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 53,
                                height: 53,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColor.c4275f6
                                      : Colors.white, // Background color
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ClipOval(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      AppIcons.sportCard,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black, // Icon color
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Autographed \nmemorabilia',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: isSelected
                                      ? AppColor.c4275f6
                                      : AppColor.cABABAB, // Text color
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    // Centers everything inside the container
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              AppImages.shoeImage,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Vertically centers text in Column
                          children: [
                            Text(
                              'Vintage Collection Item 1',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.c000000,
                                fontSize: 12,
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
                                  '\$24,500',
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
                                  '20 bids',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    color: AppColor.cF15E17,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Time Ended (Today 11:50 AM)',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    color: AppColor.c000000,
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
                                Text(
                                  '01: 23s remaining',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    color: AppColor.c000000,
                                    fontSize: 10,
                                  ),
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

                // * ##################### Popular Makes Text #####################
                SizedBox(height: 10),

                // * ##################### Popular Makes Item Card ################
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
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.5, // Adjust aspect ratio as needed
                  ),
                  itemCount: 4, // Replace with your data count
                  itemBuilder: (context, index) {
                    return Center(
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
                                    AppImages.productImage,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Product Title & Price
                                Text(
                                  'Yugioh Speed Duel Battle City FINALS Brand New Factory Sealed',
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
                                  'Pre-Owned',
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
                                      '\$15,000',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'lostrav_6599.5%',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          'positive (595)',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // * Bid Status
                                Row(
                                  children: [
                                    Text(
                                      '0 bids',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.red),
                                    ),
                                    Text(
                                      ' • Ended (Today 11:50 AM)',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '+\$19.15 delivery',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                // *  Seller info
                                Text(
                                  'From Australia',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
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
