// ignore_for_file: unused_element, library_private_types_in_public_api
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/features/chat/presentation/chat_screen.dart';
import 'package:ddavila/features/user_app/home_screen/presentation/home_screen.dart';
import 'package:ddavila/features/user_app/products_screen/products_screen.dart';
import 'package:ddavila/features/user_app/profile_screen/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'assets_helper/app_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool showOverlay = true;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  // * Screen List
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProductsScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            bottomNavigationBar: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                IndexedStack(
                  index: selectedIndex, // This tells which screen to show
                  children: _screens,
                ),
                Positioned(
                  bottom: 30.h,
                  left: 30.w,
                  right: 30.w,
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
              ],
            ),
          ),
        ),
      ],
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
          shape: BoxShape.circle, // শুধু circle, কোনো borderRadius নেই
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
