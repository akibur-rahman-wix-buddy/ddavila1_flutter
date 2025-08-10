import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      AppIcons.arrowBack,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  Text("Checkout",
                      style: TextFontStyle.textLine20w400cFFFFFFDvSans
                          .copyWith(color: Colors.black)),
                  SizedBox(
                    width: 45,
                  )
                ],
              ),
              UIHelper.verticalSpace(24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6F8FA) /* greyscale-default-25 */,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color:
                            const Color(0xFFDFE1E6) /* greyscale-default-100 */,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shipping Address",
                                  style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                      .copyWith(color: Colors.black)),
                              Container(
                                height: 32,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(
                                          0xFFC1C7CF) /* greyscale-default-200 */,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0F0D0D12),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.edit_calendar_rounded,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    Text("Edit")
                                  ],
                                ),
                              )
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          Row(
                            children: [
                              Container(
                                // width: 32,
                                // height: 32,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(
                                          0xFFC1C7CF) /* greyscale-default-200 */,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0F0D0D12),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Center(
                                        child: Icon(
                                          Icons.location_on,
                                          size: 30,
                                        ))),
                              ),
                              UIHelper.horizontalSpace(12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("My Home",
                                        style: TextFontStyle
                                            .textLine20w400cFFFFFFDvSans
                                            .copyWith(color: Colors.black)),
                                    SizedBox(
                                      child: Text(
                                          "Komplek Situ Udik, Jl. Raya Dramaga Jawa Barat 16310",
                                          style: TextFontStyle
                                              .textLine20w400cFFFFFFDvSans
                                              .copyWith(
                                              color: AppColor.c666D80,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    UIHelper.verticalSpace(8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: AppColor.c666D80,
                                        ),
                                        Text("2 days estimate arrived",
                                            style: TextFontStyle
                                                .textLine20w400cFFFFFFDvSans
                                                .copyWith(
                                                color: AppColor.c666D80,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6F8FA) /* greyscale-default-25 */,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color:
                            const Color(0xFFDFE1E6) /* greyscale-default-100 */,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order Details",
                                  style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                      .copyWith(color: Colors.black)),
                              Container(
                                height: 32,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF4275F6),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(
                                          0xFF4275F6) /* greyscale-default-200 */,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0F0D0D12),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    Text(
                                      "Add Order",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFECEFF3), // greyscale-default-50
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.58,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                      color: const Color(0xFFDFE1E6), // greyscale-default-100
                                    ),
                                    borderRadius: BorderRadius.circular(11.63),
                                  ),
                                ),
                                child: Image.asset(
                                  AppImages.productImage,
                                  width: 103.49,
                                  height: 155.81,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Home",
                                      style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                          .copyWith(color: Colors.black),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "Size = L",
                                      style: TextFontStyle.textLine20w400cFFFFFFDvSans.copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.watch_later_outlined,
                                              color: AppColor.c666D80,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "\$9.00",
                                              style: TextFontStyle.textLine20w400cFFFFFFDvSans.copyWith(
                                                color: AppColor.blackColor,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: const Color(0xFFC1C7CF), // greyscale-default-200
                                              ),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x0F0D0D12),
                                                blurRadius: 2,
                                                offset: Offset(0, 1),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.location_on,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(12.h),
                          Text("Notes",
                              style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                  .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500)),
                          Text("--",
                              style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                  .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(24),
                    ReUseAbleCheckoutCard(
                      title: "Choose Deliver",
                      icon: AppIcons.carIcon,
                      subTitle: "Choose Deliver",
                      cardName: "Delivery",
                    ),
                    UIHelper.verticalSpace(24),
                    ReUseAbleCheckoutCard(
                      title: "User Voucher",
                      icon: AppIcons.voucherCard,
                      subTitle: "Save orders with promo",
                      cardName: "Order Discount",
                    ),
                    UIHelper.verticalSpace(24),
                    ReUseAbleCheckoutCard(
                      title: "Choose Payment",
                      icon: AppIcons.creditCard,
                      subTitle: "Choose your payment method",
                      cardName: "Payment Method",
                    ),
                    UIHelper.verticalSpace(24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6F8FA) /* greyscale-default-25 */,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color:
                            const Color(0xFFDFE1E6) /* greyscale-default-100 */,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shipping Address",
                                  style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                      .copyWith(color: Colors.black)),
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                          UIHelper.verticalSpace(16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service Fee",
                                  style: TextFontStyle.buttonTextStyle
                                      .copyWith(color: Colors.black45)),
                              Text("\$6.45",
                                  style: TextFontStyle.buttonTextStyle
                                      .copyWith(color: Colors.black45)),
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Payment",
                                  style: TextFontStyle.buttonTextStyle.copyWith(
                                      color: Colors.black45, fontSize: 16)),
                              Text("\$6.45",
                                  style: TextFontStyle.buttonTextStyle.copyWith(
                                      color: Colors.black45, fontSize: 16)),
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                          UIHelper.verticalSpace(16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shipping Address",
                                  style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                      .copyWith(color: Colors.black)),
                              Text("\$6.65",
                                  style: TextFontStyle.textLine20w400cFFFFFFDvSans
                                      .copyWith(color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(18.h),
                    CustomButton(
                      text: "Continue to Payment",
                      context: context,
                      minWidth: double.infinity,
                    )
                  ],
                ),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}








class ReUseAbleCheckoutCard extends StatelessWidget {
  const ReUseAbleCheckoutCard({
    super.key,
    required this.cardName,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  final String cardName;
  final String title;
  final String subTitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F8FA) /* greyscale-default-25 */,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFDFE1E6) /* greyscale-default-100 */,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cardName,
              style: TextFontStyle.textLine20w400cFFFFFFDvSans
                  .copyWith(color: Colors.black)),
          UIHelper.verticalSpace(16.h),



          ElevatedButton(
            onPressed: () {
              // Your onPressed logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFFFF),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(color: Color(0xFFDFE1E6), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFC1C7CF),
                          ),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0F0D0D12),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Center(child: SvgPicture.asset(icon)),
                    ),
                    SizedBox(width: 8.w), // UIHelper.horizontalSpace(8.w)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextFontStyle.buttonTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          subTitle,
                          style: TextFontStyle.buttonTextStyle.copyWith(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset(AppIcons.arrowLeftRightIcon),
              ],
            ),
          ),





          // Container(
          //   width: double.infinity,
          //   padding:
          //       const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 8),
          //   decoration: ShapeDecoration(
          //     color: const Color(0xFFF6F8FA) /* greyscale-default-25 */,
          //     shape: RoundedRectangleBorder(
          //       side: BorderSide(
          //         width: 1,
          //         color: const Color(0xFFDFE1E6) /* greyscale-default-100 */,
          //       ),
          //       borderRadius: BorderRadius.circular(100),
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           Container(
          //             padding: const EdgeInsets.all(8),
          //             decoration: ShapeDecoration(
          //               shape: RoundedRectangleBorder(
          //                 side: BorderSide(
          //                   width: 1,
          //                   color: const Color(
          //                       0xFFC1C7CF) /* greyscale-default-200 */,
          //                 ),
          //                 borderRadius: BorderRadius.circular(100),
          //               ),
          //               shadows: [
          //                 BoxShadow(
          //                   color: Color(0x0F0D0D12),
          //                   blurRadius: 2,
          //                   offset: Offset(0, 1),
          //                   spreadRadius: 0,
          //                 )
          //               ],
          //             ),
          //             child: Align(
          //                 alignment: Alignment.center,
          //                 child: Center(child: SvgPicture.asset(icon))),
          //           ),
          //           UIHelper.horizontalSpace(8.w),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(title,
          //                   style: TextFontStyle.buttonTextStyle
          //                       .copyWith(color: Colors.black)),
          //               Text(subTitle,
          //                   style: TextFontStyle.buttonTextStyle
          //                       .copyWith(color: Colors.black45, fontSize: 12)),
          //             ],
          //           ),
          //         ],
          //       ),
          //       SvgPicture.asset(AppIcons.arrowLeftRightIcon)
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
