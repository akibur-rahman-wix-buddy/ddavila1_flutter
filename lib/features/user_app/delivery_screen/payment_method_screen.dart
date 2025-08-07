import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int? _selectedIndex; // Track the selected card index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Payment Method'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _buildPaymentCard(
                    0, AppImages.paypalPay, 'PayPal Pay'), // First card
                SizedBox(height: 10), // Add spacing
                _buildPaymentCard(
                    1, AppImages.googlePay, 'Google Pay'), // Second card
                SizedBox(height: 10),
                _buildPaymentCard(
                    2, AppImages.applePay, 'Apple Pay'), // Third card
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

  Widget _buildPaymentCard(int index, String imagePath, String title) {
    bool isSelected = _selectedIndex == index; // Check if this card is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Update selected index on tap
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.cDBE5FD
              : Colors.white, // Blue if selected, else white
          borderRadius: BorderRadius.circular(60),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    imagePath,
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
              if (isSelected) // Show done icon only if selected
                SvgPicture.asset(AppIcons.done),
            ],
          ),
        ),
      ),
    );
  }
}
