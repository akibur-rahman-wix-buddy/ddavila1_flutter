import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/widget/sale_product_details.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.slug});
  final String slug;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String? stateName;
  String? myStateName;
  double productPercentage = 0.0;
  double myShippingCost = 0.0;
  bool isWhiteListing = false;
  bool _isProcessing = false;
  dynamic myId;
  ProductDetailsDataModel? productData;

  @override
  void initState() {
    super.initState();
    myStateName = appData.read(kKeyMyState);
    myId = appData.read(kKeyUserID);
    _initializeData();
  }

  Future<void> _initializeData() async {
    await fetchStates();
    await productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
  }

  Future<void> fetchStates() async {
    try {
      final StateDataModel? data = await getStateRx.getStateInfo();
      if (data != null && data.data != null && data.data!.isNotEmpty) {
        for (var item in data.data!) {
          if (item.slug == myStateName) {
            setState(() {
              stateName = item.title;
              productPercentage = item.percentage?.toDouble() ?? 0.0;
            });
            break;
          }
        }
      }
    } catch (e, stackTrace) {
      log("Fetch States Error: $e");
      log("Stack trace: $stackTrace");
      setState(() => productPercentage = 0.0);
    }
  }

  double calculateTotalAmount(SaleData product) {
    double productPrice = double.tryParse(product.price?.toString() ?? '0') ?? 0.0;
    double taxAmount = productPrice * (productPercentage) / 100;
    return productPrice + taxAmount + myShippingCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<ProductDetailsDataModel>(
          stream: productViewDetailsRx.dataFetcher,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data?.data == null) {
              return const Center(child: Text("No data found."));
            } else {
              final data = snapshot.data!.data!;
              productData = snapshot.data;

              myShippingCost = double.tryParse(data.shippingCost ?? '0') ?? 0.0;
              final totalAmount = calculateTotalAmount(data);

              return ProductDetailsBody(
                data: data,
                stateName: stateName,
                productPercentage: productPercentage,
                myShippingCost: myShippingCost,
                totalAmount: totalAmount,
                isWhiteListing: isWhiteListing,
                isProcessing: _isProcessing,
                myId: myId,
                onToggleProcessing: (value) {
                  setState(() => _isProcessing = value);
                },
                onToggleWhiteListing: (value) {
                  setState(() => isWhiteListing = value);
                },
                slug: widget.slug,
              );
            }
          },
        ),
      ),
    );
  }
}
