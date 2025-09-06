// ignore_for_file: library_private_types_in_public_api, prefer_initializing_formals, must_be_immutable
import 'dart:developer';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class FinalProductEditScreen extends StatefulWidget {
  dynamic titleText,
      descriptionText,
      subCategory,
      category,
      propertyTitle,
      propertyValue,
      imageItem,
      type,
      productID,
      // * auction data
      auctionEndDate,
      buyNowPrice,
      shipWithin,
      startingPrice,
      shippingCost;

  FinalProductEditScreen({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.subCategory,
    required this.category,
    required this.propertyTitle,
    required this.propertyValue,
    required this.imageItem,
    this.type,
    this.productID,
    // * auction data
    this.auctionEndDate, // * ache
    this.buyNowPrice, // * ache
    this.shipWithin, // * ache
    this.shippingCost, // * ache
    this.startingPrice, // * ache
  });

  @override
  _FinalProductEditScreenState createState() => _FinalProductEditScreenState();
}

class _FinalProductEditScreenState extends State<FinalProductEditScreen> {
  final TextEditingController buyNowPriceController = TextEditingController();
  final TextEditingController startingPriceController = TextEditingController();
  final TextEditingController auctionEndDateController =
      TextEditingController();
  final TextEditingController shipWithinController = TextEditingController();
  final TextEditingController shippingCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('############################## Data Come from create auction ################################');
    log('Final Product ID: ${widget.productID}');
    log('Final Auction Title: ${widget.titleText}');
    log('Final Auction Description: ${widget.descriptionText}');
    log('Final Auction Sub Category: ${widget.subCategory}');
    log('Final Auction Category: ${widget.category}');
    log('Final Auction Property Title: ${widget.propertyTitle}');
    log('Final Auction Property Value: ${widget.propertyValue}');
    log('Final Auction Images: ${widget.imageItem}');
    log('Final Auction Type: ${widget.type}');
    log('Final Auction End Date: ${widget.auctionEndDate}');
    log('Final Buy Now Price: ${widget.buyNowPrice}');
    log('Final Ship Within: ${widget.shipWithin}');
    log('Final Shipping Cost: ${widget.shippingCost}');
    log('#############################################################################################');

    String formatDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) return '';

      try {
        DateTime parsedDate = DateTime.parse(dateString);
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      } catch (e) {
        return '';
      }
    }

    shipWithinController.text = widget.shipWithin ?? '';
    shippingCostController.text = widget.shippingCost ?? '';
    buyNowPriceController.text = widget.buyNowPrice ?? '';
    auctionEndDateController.text = formatDate(widget.auctionEndDate);
    startingPriceController.text = widget.startingPrice ?? '';

    return Scaffold(
      appBar: CustomAppBar(text: 'Edit Product'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 28.h),

              // widget.type অনুযায়ী UI দেখানো
              if (widget.type == "auction") ...[
                // Auction Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starting Price',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'Enter Starting Price',
                      controller: startingPriceController,
                    ),
                    SizedBox(height: 20.h),

                    // Auction End Date
                    Text(
                      'Auction End Date',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            auctionEndDateController.text =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                          }
                        },
                        child: SvgPicture.asset(
                          AppIcons.calendarIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      hintText: 'Select auction end date',
                      controller: auctionEndDateController,
                      readOnly: true,
                    ),
                    SizedBox(height: 20.h),

                    // Ship within & Shipping cost
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ship within (days)',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: shipWithinController,
                                hintText: '0',
                                fieldWidth: 160.w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Cost',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: shippingCostController,
                                hintText: '0',
                                fieldWidth: 160.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ] else ...[
                // Sale Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buy Now Price',
                      style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'Enter Buy Now Price',
                      controller: buyNowPriceController,
                      readOnly: true,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ship within (days)',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: shipWithinController,
                                hintText: '0',
                                fieldWidth: 160.w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Cost',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              CustomTextField(
                                controller: shippingCostController,
                                hintText: '0',
                                fieldWidth: 160.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],

              SizedBox(height: 32.h),

              // Button Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onTap: () {
                      NavigationService.goBack;
                    },
                    text: 'Back',
                    context: context,
                    minWidth: 160.w,
                    color: AppColor.cF3F2F2,
                    borderRadius: 12.r,
                    textStyle:
                        TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c3988FF,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomButton(
                    onTap: () async {
                      List<XFile> imagees = (widget.imageItem as List<dynamic>)
                          .map((path) => XFile(path as String))
                          .toList();

                      if (widget.type == "auction") {
                        log("################# Auction ####################");
                        log('Starting Price: ${startingPriceController.text}');
                        log('Auction End Date: ${auctionEndDateController.text}');
                        log('Shipping Cost: ${shippingCostController.text}');
                        log('Ship Within: ${shipWithinController.text}');
                        log("###################################################");

                        bool success =
                            await postAuctionProductAPIRx.postProductAuctionRX(
                          title: widget.titleText.toString(),
                          description: widget.descriptionText,
                          categoryId: widget.category,
                          subcategoryId: widget.subCategory,
                          auction_end_at: auctionEndDateController.text,
                          type: 'auction',
                          shippingCost:
                              double.tryParse(shippingCostController.text) ??
                                  0.0,
                          price: startingPriceController.text,
                          shipWithin: shipWithinController.text,
                          images: imagees,
                          propertyItem: widget.propertyTitle,
                          propertyValue: widget.propertyValue,
                        );

                        if (success) {
                          ToastUtil.showShortToast(
                            'Product Posted Successfully',
                          );
                        } else {
                          ToastUtil.showShortToast(
                            'Product Post Failed',
                          );
                        }
                      } else {
                        log("################# Sale ####################");
                        log('Buy Now Price: ${buyNowPriceController.text}');
                        log('Shipping Cost: ${shippingCostController.text}');
                        log('Ship Within: ${shipWithinController.text}');
                        log("###################################################");

                        bool success =
                            await editSellerProductAPIRX.updateSaleProductsRX(
                          productId: widget.productID,
                          title: widget.titleText.toString(),
                          description: widget.descriptionText,
                          categoryId: widget.category,
                          subcategoryId: widget.subCategory,
                          type: 'sale',
                          images: imagees,
                          propertyItem: widget.propertyTitle,
                          propertyValue: widget.propertyValue,

                          // * sales data
                          shippingCost:
                              double.tryParse(shippingCostController.text) ??
                                  0.0,
                          buyNowPrice:
                              "185", //buyNowPriceController.text.toString(),
                          shipWithin: shipWithinController.text.toString(),
                        );

                        if (success) {
                          ToastUtil.showShortToast(
                            'Product Posted Successfully',
                          );
                        } else {
                          ToastUtil.showShortToast(
                            'Product Post Failed',
                          );
                        }
                      }
                    },
                    text: 'Next',
                    context: context,
                    minWidth: 160.w,
                    color: AppColor.c3988FF,
                    borderRadius: 12.r,
                    textStyle:
                        TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.cFFFFFF,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
