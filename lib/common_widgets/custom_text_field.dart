// // ignore_for_file: non_constant_identifier_names
//
// import 'package:errolspreadlove_app/assets_helper/app_colors.dart';
// import 'package:errolspreadlove_app/assets_helper/app_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomTextFormField extends StatelessWidget {
//   const CustomTextFormField({
//     super.key,
//     this.level,
//     this.controller,
//     this.inputType,
//     this.fieldHeight,
//     this.maxLine,
//     this.prefixIcon,
//     this.hintText,
//     this.minLIne,
//     this.height,
//     this.hintStyle,
//     this.obscureText,
//     this.keyboardType,
//     this.maxLength,
//     this.Name,
//   });
//
//   final String? level;
//   final String? hintText;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final double? fieldHeight;
//   final int? maxLine;
//   final int? minLIne;
//   final Widget? prefixIcon;
//   final double? height;
//   final TextStyle? hintStyle;
//   final bool? obscureText;
//   final TextInputType? keyboardType;
//   final int? maxLength;
//   final String? Name;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         alignment: Alignment.topLeft,
//         height: height ?? 75.h,
//         width: 325.w,
//         decoration: BoxDecoration(
//             color: AppColor.blackColor.withOpacity(0.07),
//             borderRadius: BorderRadius.circular(10.r)),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Remove the vertical space and place the Text directly
//               Padding(
//                 padding: const EdgeInsets.only(top: 5),
//                 child: Text(
//                   Name ?? "",
//                   style: TextFontStyle.textStyle16PoppinsW600.copyWith(
//                     fontSize: 11,
//                     color: AppColor.blackColor.withOpacity(0.5),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 0), // Ensure no extra spacing here
//               TextField(
//                 maxLength: maxLength,
//                 keyboardType: keyboardType,
//                 obscureText: obscureText ?? false,
//                 obscuringCharacter: "*",
//                 controller: controller,
//                 minLines: minLIne,
//                 maxLines: maxLine ?? 1,
//                 style: TextFontStyle.textStyle14PoppinsW600.copyWith(
//                   fontSize: 14.sp,
//                 ),
//                 decoration: InputDecoration(
//                   alignLabelWithHint: false,
//                   prefixIcon: prefixIcon != null
//                       ? Padding(
//                           padding: EdgeInsets.all(12.sp),
//                           child: prefixIcon,
//                         )
//                       : null,
//                   border: InputBorder.none,
//                   hintText: hintText,
//                   hintStyle:
//                       hintStyle ?? TextFontStyle.textStyle12PoppinsW500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
