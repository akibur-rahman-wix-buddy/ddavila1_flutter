// ignore_for_file: unused_element, library_private_types_in_public_api, deprecated_member_use
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/admin_app/auction_screen/my_auction_screen.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/admin_dashboard_screen.dart';
import 'package:ddavila/features/admin_app/wishlist_screen/admin_wishlist_screen.dart';
import 'package:ddavila/features/user_app/profile_screen/presentation/profile_screen.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminNavigationScreen extends StatefulWidget {
  const AdminNavigationScreen({super.key});

  @override
  _AdminNavigationScreenState createState() => _AdminNavigationScreenState();
}

class _AdminNavigationScreenState extends State<AdminNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = [
    const AdminDashboardScreen(),
    const AuctionScreen(),
    const AdminWishListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),

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
              _buildNavItem(AppIcons.navLove, 2),
              _buildNavItem(AppIcons.profileNav, 3),
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
