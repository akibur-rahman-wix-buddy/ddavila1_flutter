
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/widget/bit_product_image_slider.dart';
import 'package:ddavila/features/user_app/products_screen/widget/sale_product_card_info.dart';
import 'package:flutter/material.dart';

class ProductDetailsBody extends StatelessWidget {
  final SaleData data;
  final String? stateName;
  final double productPercentage;
  final double myShippingCost;
  final double totalAmount;
  final bool isWhiteListing;
  final bool isProcessing;
  final dynamic myId;
  final String slug;
  final ValueChanged<bool> onToggleProcessing;
  final ValueChanged<bool> onToggleWhiteListing;

  const ProductDetailsBody({
    super.key,
    required this.data,
    required this.stateName,
    required this.productPercentage,
    required this.myShippingCost,
    required this.totalAmount,
    required this.isWhiteListing,
    required this.isProcessing,
    required this.myId,
    required this.onToggleProcessing,
    required this.onToggleWhiteListing,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(image: data.productDetailsImages ?? []),
          ProductInfoCard(
            data: data,
            stateName: stateName,
            productPercentage: productPercentage,
            myShippingCost: myShippingCost,
            totalAmount: totalAmount,
            isWhiteListing: isWhiteListing,
            myId: myId,
            onToggleProcessing: onToggleProcessing,
            onToggleWhiteListing: onToggleWhiteListing,
            slug: slug,
          ),
        ],
      ),
    );
  }
}
