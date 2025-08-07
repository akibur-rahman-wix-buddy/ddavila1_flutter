import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cFFFFFF,
      appBar: CustomAppBar(text: 'Delivery Address'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _buildAddressCard(0),
                SizedBox(height: 20),
                _buildAddressCard(1),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Add New Address',
                  context: context,
                  minWidth: double.infinity,
                  color: AppColor.cFFFFFF,
                  borderColor: AppColor.cABABAB,
                  textStyle: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 85,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.cFFFFFF,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomButton(
                minWidth: double.infinity,
                text: 'Confirm',
                context: context,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildAddressCard(int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.cDBE5FD : AppColor.cF6F8FA,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.cDFE1E6,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.cF6F8FA,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'My Home',
                        style:
                            TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                          color: AppColor.c000000,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isSelected) ...[
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.cFFFFFF,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5,
                            ),
                            child: Text(
                              'Main Address',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                color: AppColor.c3988FF,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(width: 10),
                  if (isSelected)
                    SvgPicture.asset(
                      AppIcons.done,
                    ),
                ],
              ),
              Divider(
                color: AppColor.cDFE1E6,
                thickness: 1,
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Fajar Kun | ',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '+62 809012002',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Komplek Situ Udik, Jl. Raya Dramaga Jawa Barat 16310',
                  style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                    color: AppColor.c000000,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.clockIcon,
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Pinpoint already',
                    style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                      color: AppColor.c000000,
                      fontSize: 12,
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
