// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../constants/text_font_style.dart';
// import '../gen/assets.gen.dart';
// import '../gen/colors.gen.dart';
// import '../helpers/navigation_service.dart';
//
// class MyOrderCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
//   const MyOrderCustomAppbar({
//     super.key,
//     this.title,
//     this.calender = false, // Default to false if not passed
//     this.onCallBack,
//     this.leadingIconUnVisibl = false,
//     this.actions,
//     this.isCenterd = false,
//     this.background,
//   });
//
//   final String? title;
//   final bool calender; // To decide whether to show calendar icon
//   final VoidCallback? onCallBack;
//   final bool leadingIconUnVisibl;
//   final List<Widget>? actions;
//   final bool isCenterd;
//   final Color? background;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       leading: leadingIconUnVisibl
//           ? null
//           : Padding(
//         padding: EdgeInsets.all(10.sp),
//         child: InkWell(
//           onTap: onCallBack ?? () => NavigationService.goBack(),
//           child: Container(
//             height: 40.h,
//             width: 40.w,
//             decoration: BoxDecoration(
//               color: AppColors.cFFFFFF,
//               borderRadius: BorderRadius.circular(16.r),
//             ),
//             child: SvgPicture.asset(
//               Assets.icons.arrowPrevious,
//               height: 28.h,
//               width: 28.w,
//               color: AppColors.c000000,
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: background ?? AppColors.c1F2428,
//       centerTitle: isCenterd,
//       title: Text(
//         title ?? '',
//         style: TextFontStyle.textLine16w500cFFFFFFPoppins,
//       ),
//       actions: [
//         // Add the Calendar icon here if `calender` is true
//         if (calender)
//           Padding(
//             padding: EdgeInsets.all(10.sp),
//             child: InkWell(
//               onTap: onCallBack ?? () => print("Calendar Icon Clicked"), // Handle calendar click
//               child: Container(
//                 height: 30.h,
//
//                 width: 30.w,
//                 padding: const EdgeInsets.all(7),
//                 decoration: BoxDecoration(
//                   color: AppColors.cFFFFFF,
//                   borderRadius: BorderRadius.circular(22.r),
//                 ),
//                 child: SvgPicture.asset(
//                   Assets.icons.calendarWhite, // Replace with your actual calendar asset
//                   height: 30.h, // Adjust height of the icon if necessary
//                   width: 30.w, // Adjust width of the icon if necessary
//                   color: Colors.green, // Ensure icon color is the same as the back button
//                 ),
//               ),
//             ),
//           ),
//         // If you have other actions, you can add them here
//         if (actions != null) ...actions!,
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
