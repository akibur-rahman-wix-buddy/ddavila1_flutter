// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../constants/text_font_style.dart';
// import '../gen/colors.gen.dart';
//
// class CustomTextFieldWithIcon extends StatelessWidget {
//   const CustomTextFieldWithIcon({
//     super.key,
//     required this.level,
//     this.controller,
//     this.inputType,
//     this.fieldHeight,
//     this.maxline,
//     this.suffixIcon,
//     this.prefixIcon, this.onCallBack,
//
//   });
//
//   final VoidCallback? onCallBack;
//   final String level;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final double? fieldHeight;
//   final int? maxline;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onCallBack,
//       child: Container(
//         height: 56.h,
//         width: 325.w,
//         decoration: BoxDecoration(
//             color: AppColors.cFFFFFF.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10.r)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: TextFormField(
//             controller: controller,
//             style: TextFontStyle.textLine12w500cFFFFFFPoppins,
//             decoration: InputDecoration(
//                 suffixIcon: suffixIcon != null
//                     ? Padding(
//                   padding: EdgeInsets.all(12.sp),
//                   child: suffixIcon,
//                 )
//                     : null,
//                 prefixIcon: prefixIcon != null
//                     ? Padding(
//                   padding: EdgeInsets.all(12.sp),
//                   child: prefixIcon,
//                 )
//                     : null,
//                 label: Text(
//                   level,
//                   style: TextFontStyle.textLine9w400cFFFFFFPoppins
//                       .copyWith(color: AppColors.cFFFFFF),
//                 ),
//                 labelStyle: TextFontStyle.textLine12w500cFFFFFFPoppins,
//                 border: InputBorder.none),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class CustomTextFieldWithIcon extends StatelessWidget {
//   const CustomTextFieldWithIcon({
//     super.key,
//     required this.level,
//     this.controller,
//     this.inputType,
//     this.fieldHeight,
//     this.maxline,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.onChanged,// Add onChanged as a parameter
//   });
//
//   final Function(String)? onChanged; // Callback to handle the change
//   final String level;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final double? fieldHeight;
//   final int? maxline;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onChanged != null ? () => onChanged!(controller?.text ?? '') : null,
//       child: Container(
//         height: 56.h,
//         width: 325.w,
//         decoration: BoxDecoration(
//             color: AppColors.cFFFFFF.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10.r)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: TextFormField(
//             controller: controller,
//             style: TextFontStyle.textLine12w500cFFFFFFPoppins,
//             onChanged: onChanged, // Attach the onChanged callback here
//             decoration: InputDecoration(
//                 suffixIcon: suffixIcon != null
//                     ? Padding(
//                   padding: EdgeInsets.all(12.sp),
//                   child: suffixIcon,
//                 )
//                     : null,
//                 prefixIcon: prefixIcon != null
//                     ? Padding(
//                   padding: EdgeInsets.all(12.sp),
//                   child: prefixIcon,
//                 )
//                     : null,
//                 label: Text(
//                   level,
//                   style: TextFontStyle.textLine9w400cFFFFFFPoppins
//                       .copyWith(color: AppColors.cFFFFFF),
//                 ),
//                 labelStyle: TextFontStyle.textLine12w500cFFFFFFPoppins,
//                 border: InputBorder.none),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
