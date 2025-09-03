// ignore_for_file: library_private_types_in_public_api, prefer_initializing_formals, must_be_immutable
import 'dart:developer';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class FinalAuctionScreen extends StatefulWidget {
  dynamic titleText, descriptionText, subCategory, category, property, imageItem;
  FinalAuctionScreen(
      {super.key,
      required titleText,
      required descriptionText,
      required subCategory,
      required category,
      required property,
      required imageItem}) {
    this.titleText = titleText;
    this.descriptionText = descriptionText;
    this.subCategory = subCategory;
    this.category = category;
    this.property = property;
    this.imageItem = imageItem;
  }

  @override
  _FinalAuctionScreenState createState() => _FinalAuctionScreenState();
}

class _FinalAuctionScreenState extends State<FinalAuctionScreen> {
  bool isAuction = false;
  final TextEditingController startingPriceController = TextEditingController();
  final TextEditingController buyNowPriceController = TextEditingController();
  final TextEditingController auctionEndDateController =
      TextEditingController();
  final TextEditingController shipWithinController = TextEditingController();
  final TextEditingController shippingCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('############################## Data Come from create auction ################################');
    log('Final Auction Title: ${widget.titleText}');
    log('Final Auction Description: ${widget.descriptionText}');
    log('Final Auction Sub Category: ${widget.subCategory}');
    log('Final Auction Category: ${widget.category}');
    log('Final Auction Property: ${widget.property}');
    log('Final Auction Images: ${widget.imageItem}');
    log('#############################################################################################');
    return Scaffold(
      appBar: CustomAppBar(text: 'Create Auction'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Auction Radio Button Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Auction',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 18.sp,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Radio<bool>(
                    value: false,
                    groupValue: isAuction,
                    activeColor: AppColor.blackColor,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isAuction = value;
                          log(isAuction ? 'Auction' : 'Sale');
                        });
                      }
                    },
                  ),
                  Text(
                    'No',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Radio<bool>(
                    value: true,
                    groupValue: isAuction,
                    activeColor: AppColor.blackColor,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isAuction = value;
                          log(isAuction ? 'Auction' : 'Sale');
                        });
                      }
                    },
                  ),
                  Text(
                    'Yes',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              if (isAuction) ...[
                // Auction Yes Section
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
                      controller: startingPriceController,
                      hintText: 'Enter Starting Price',
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 20.h),
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
                            firstDate: DateTime(2000), // minimum date
                            lastDate: DateTime(2100), // maximum date
                          );

                          if (pickedDate != null) {
                            // format the date as yyyy-MM-dd
                            String formattedDate =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                            auctionEndDateController.text = formattedDate;
                          }
                        },
                        child: SvgPicture.asset(AppIcons.cameraIcon),
                      ),
                      hintText: 'Select auction end date',
                      controller: auctionEndDateController,
                      onChanged: (value) {
                        // Handle the input value
                      },
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
                                onChanged: (value) {
                                  // Handle the input value
                                },
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
                                hintText: '0',
                                controller: shippingCostController,
                                fieldWidth: 160.w,
                                onChanged: (value) {
                                  // Handle the input value
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ] else ...[
                // Auction No Section
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
                      onChanged: (value) {
                        // Handle the input value
                      },
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
                                hintText: '0',
                                controller: shipWithinController,
                                fieldWidth: 160.w,
                                onChanged: (value) {
                                  // Handle the input value
                                },
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
                                onChanged: (value) {
                                  // Handle the input value
                                },
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
                    onTap: () {},
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
                      // Convert List<String> to List<XFile>
                      List<XFile> imagees = (widget.imageItem as List<dynamic>)
                          .map((path) => XFile(path as String))
                          .toList();
                      if (isAuction) {
                        log("################# Auction True ####################");
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
                          propertyItem: widget.property
                              .map<String>(
                                (item) => "${item['title']}, ${item['value']}",
                          )
                              .toList(),
                        );
                        if (success) {
                          ToastUtil.showShortToast(
                            'Product Posted Successfully',
                          );
                        } else {
                          log('==========================>>>>>> Auction Starting Price : ${startingPriceController.text}');
                          ToastUtil.showShortToast(
                            'Product Posted UnSuccessful',

                          );
                        }


                      } else {
                        log("################# Auction False ####################");
                        log('Buy Now Price: ${buyNowPriceController.text}');
                        log('Shipping Cost: ${shippingCostController.text}');
                        log('Ship Within: ${shipWithinController.text}');
                        log("#####################################################");
                        bool success =
                            await postProductsAPIRxObj.postProductSaleRX(
                          title: widget.titleText.toString(),
                          description: widget.descriptionText,
                          categoryId: widget.category,
                          subcategoryId: widget.subCategory,
                          type: 'sale',
                          shippingCost:
                              double.tryParse(shippingCostController.text) ??
                                  0.0,
                          price: buyNowPriceController.text,
                          shipWithin: shipWithinController.text,
                          images: imagees,
                          propertyItem: widget.property
                              .map<String>(
                                (item) => "${item['title']}, ${item['value']}",
                              )
                              .toList(),
                        );
                        if (success) {
                          ToastUtil.showShortToast(
                            'Product Posted Successfully',
                          );
                        } else {
                          ToastUtil.showShortToast(
                            'Product Posted UnSuccessful',
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
