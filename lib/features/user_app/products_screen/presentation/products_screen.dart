// import 'dart:developer';
// import 'package:ddavila/constants/app_constants.dart';
// import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
// import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
// import 'package:ddavila/features/user_app/products_screen/widget/sale_product_details.dart';
// import 'package:ddavila/helpers/di.dart';
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
//
// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({super.key, required this.slug});
//   final String slug;
//
//   @override
//   State<ProductsScreen> createState() => _ProductsScreenState();
// }
//
// class _ProductsScreenState extends State<ProductsScreen> {
//   String? stateName;
//   String? myStateName;
//   double productPercentage = 0.0;
//   double myShippingCost = 0.0;
//   bool isWhiteListing = false;
//   bool _isProcessing = false;
//   dynamic myId;
//   ProductDetailsDataModel? productData;
//
//   @override
//   void initState() {
//     super.initState();
//     myStateName = appData.read(kKeyMyState);
//     myId = appData.read(kKeyUserID);
//     _initializeData();
//   }
//
//   Future<void> _initializeData() async {
//     await fetchStates();
//     await productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
//   }
//
//   Future<void> fetchStates() async {
//     try {
//       final StateDataModel? data = await getStateRx.getStateInfo();
//       if (data != null && data.data != null && data.data!.isNotEmpty) {
//         for (var item in data.data!) {
//           if (item.slug == myStateName) {
//             setState(() {
//               stateName = item.title;
//               productPercentage = item.percentage?.toDouble() ?? 0.0;
//             });
//             break;
//           }
//         }
//       }
//     } catch (e, stackTrace) {
//       log("Fetch States Error: $e");
//       log("Stack trace: $stackTrace");
//       setState(() => productPercentage = 0.0);
//     }
//   }
//
//   double calculateTotalAmount(SaleData product) {
//     double productPrice = double.tryParse(product.price?.toString() ?? '0') ?? 0.0;
//     double taxAmount = productPrice * (productPercentage) / 100;
//     return productPrice + taxAmount + myShippingCost;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: StreamBuilder<bool>(
//             stream: productViewDetailsRx.isLoadingStream,
//             builder: (context, loadingSnapshot) {
//               return StreamBuilder<ProductDetailsDataModel>(
//               stream: productViewDetailsRx.dataFetcher,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (!snapshot.hasData || snapshot.data?.data == null) {
//                   return const Center(child: Text("No data found."));
//                 } else {
//                   final data = snapshot.data!.data!;
//                   productData = snapshot.data;
//
//                   myShippingCost = double.tryParse(data.shippingCost ?? '0') ?? 0.0;
//                   final totalAmount = calculateTotalAmount(data);
//
//                   return ProductDetailsBody(
//                     data: data,
//                     stateName: stateName,
//                     productPercentage: productPercentage,
//                     myShippingCost: myShippingCost,
//                     totalAmount: totalAmount,
//                     isWhiteListing: isWhiteListing,
//                     isProcessing: _isProcessing,
//                     myId: myId,
//                     onToggleProcessing: (value) {
//                       setState(() => _isProcessing = value);
//                     },
//                     onToggleWhiteListing: (value) {
//                       setState(() => isWhiteListing = value);
//                     },
//                     slug: widget.slug,
//                   );
//                 }
//               },
//             );
//           }
//         ),
//       ),
//     );
//   }
// }



import 'dart:developer';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/widget/sale_product_details.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
    _initializeData();
    myStateName = appData.read(kKeyMyState);
    myId = appData.read(kKeyUserID);

    // Clear previous data before loading new data
    //_clearPreviousData();

  }

  // // Clear previous data from the stream
  // void _clearPreviousData() {
  //   productViewDetailsRx.clearPreviousData();
  //   setState(() {
  //     productData = null;
  //   });
  // }



  Future<void> _initializeData() async {
    await productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
    await fetchStates();
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
        child: StreamBuilder<bool>(
          stream: productViewDetailsRx.isLoadingStream,
          builder: (context, loadingSnapshot) {
            return StreamBuilder<ProductDetailsDataModel>(
              stream: productViewDetailsRx.dataFetcher,
              builder: (context, snapshot) {
                // Show shimmer when loading
                if (loadingSnapshot.data == true) {
                  return _buildShimmerLoading();
                }

                // Show error if there's an error
                if (snapshot.hasError) {
                  return _buildErrorWidget("Error loading product: ${snapshot.error}");
                }

                // Check if we have valid data
                if (!snapshot.hasData || snapshot.data?.data == null) {
                  return _buildErrorWidget("No product data found.");
                }

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
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Price Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Description Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Details Section Shimmer
          _buildShimmerSection(),
          const SizedBox(height: 20),
          _buildShimmerSection(),
          const SizedBox(height: 20),

          // Button Shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 150,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 180,
            height: 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _initializeData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}