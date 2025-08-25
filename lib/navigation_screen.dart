// ignore_for_file: unused_element, library_private_types_in_public_api, deprecated_member_use
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/admin_app/buying/presention/buying_order.dart';
import 'package:ddavila/features/admin_app/seling/presentation/selling_order.dart';
import 'package:ddavila/features/chat/presentation/chat_screen.dart';
import 'package:ddavila/features/user_app/home_screen/presentation/home_screen.dart';
import 'package:ddavila/features/user_app/profile_screen/presentation/profile_screen.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'assets_helper/app_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    // const ProductsScreen(),
    const ChatScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),

      // ✅ ExpandableFab ঠিকভাবে কাজ করবে
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 70,
        childrenAnimation: ExpandableFabAnimation.none,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(0.3),
        ),
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: SvgPicture.asset(
            AppIcons.addIcon,
          ),
          fabSize: ExpandableFabSize.regular,
          backgroundColor: Colors.white,
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: SvgPicture.asset(
            AppIcons.crossIcon,
          ),
          fabSize: ExpandableFabSize.regular,
          backgroundColor: Colors.white,
        ),
        children: [

          GestureDetector(
          onTap: (){
            Get.to(BuyingOrderScreen());
          },
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.cFFFFFF,
                borderRadius: BorderRadius.circular(99.r),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    Text(
                      'Buying Order',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.c000000,
                      ),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton.small(
                      heroTag: 'remind',
                      backgroundColor: AppColor.cFFFFFF,
                      foregroundColor: AppColor.cFFFFFF,
                      disabledElevation: 0,
                      elevation: 0,
                      onPressed: () {
                        debugPrint("Buying Order");
                      },
                      child: SvgPicture.asset(AppIcons.orderIcon),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(

            onTap: (){
              Get.to(SellingOrder());
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.cFFFFFF,
                borderRadius: BorderRadius.circular(99.r),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      'Selling Order',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.c000000,
                      ),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton.small(
                      heroTag: 'remind',
                      backgroundColor: AppColor.cFFFFFF,
                      foregroundColor: AppColor.cFFFFFF,
                      disabledElevation: 0,
                      elevation: 0,
                      onPressed: () {
                        debugPrint("Selling Order");
                      },
                      child: SvgPicture.asset(AppIcons.orderIcon),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.cFFFFFF,
              borderRadius: BorderRadius.circular(99.r),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  Text(
                    'Whitelist',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton.small(
                    heroTag: 'remind',
                    backgroundColor: AppColor.cFFFFFF,
                    foregroundColor: AppColor.cFFFFFF,
                    disabledElevation: 0,
                    elevation: 0,
                    onPressed: () {
                      debugPrint("Whitelist");
                    },
                    child: SvgPicture.asset(AppIcons.whiteLoveIcon),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.cFFFFFF,
              borderRadius: BorderRadius.circular(99.r),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const SizedBox(width: 25),
                  Text(
                    'Bid History',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton.small(
                    heroTag: 'remind',
                    backgroundColor: AppColor.cFFFFFF,
                    foregroundColor: AppColor.cFFFFFF,
                    disabledElevation: 0,
                    elevation: 0,
                    onPressed: () {
                      debugPrint("Bid History");
                    },
                    child: SvgPicture.asset(AppIcons.bidIcon),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.cFFFFFF,
              borderRadius: BorderRadius.circular(99.r),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const SizedBox(width: 23),
                  Text(
                    'My Auction',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton.small(
                    heroTag: 'remind',
                    backgroundColor: AppColor.cFFFFFF,
                    foregroundColor: AppColor.cFFFFFF,
                    disabledElevation: 0,
                    elevation: 0,
                    onPressed: () {
                      debugPrint("My Auction");
                    },
                    child: SvgPicture.asset(AppIcons.auctionIcon),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                NavigationService.navigateTo(Routes.adminNavigationScreen),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.cFFFFFF,
                borderRadius: BorderRadius.circular(99.r),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 23),
                    Text(
                      'Dashboard',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        color: AppColor.c000000,
                      ),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton.small(
                      heroTag: 'remind',
                      backgroundColor: AppColor.cFFFFFF,
                      foregroundColor: AppColor.cFFFFFF,
                      disabledElevation: 0,
                      elevation: 0,
                      onPressed: () {
                        ToastUtil.showShortToast('Navigate To Admin Dashboard');
                      },
                      child: SvgPicture.asset(AppIcons.dasbIcon),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,

      // ✅ custom bottom navigation
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 30.w, right: 30.w),
        child: Container(
          height: 74.h,
          width: 310.w,
          decoration: BoxDecoration(
            color: AppColor.c3988FF,
            borderRadius: BorderRadius.circular(67.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(AppIcons.navHome, 0),
              _buildNavItem(AppIcons.navNote, 1),
              _buildNavItem(AppIcons.navMessage, 2),
              _buildNavItem(AppIcons.navProfile, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColor.c3988FF : AppColor.cFFFFFF,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

extension on Color {
  withValues({required double alpha}) {}
}
