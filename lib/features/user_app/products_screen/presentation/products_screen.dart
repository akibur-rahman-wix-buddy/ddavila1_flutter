// import 'dart:developer';
// import 'package:ddavila/common_widgets/custom_button.dart';
// import 'package:ddavila/constants/app_constants.dart';
// import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
// import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
// import 'package:ddavila/features/user_app/products_screen/widget/bit_product_image_slider.dart';
// import 'package:ddavila/helpers/di.dart';
// import 'package:ddavila/helpers/html_text_viewer.dart';
// import 'package:ddavila/helpers/toast.dart';
// import 'package:ddavila/helpers/ui_helpers.dart';
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ddavila/assets_helper/app_colors.dart';
// import 'package:ddavila/assets_helper/text_font_style.dart';
//
// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({super.key, required this.slug});
//
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
//   bool isLoading = false;
//   ProductDetailsDataModel? productData;
//
//   bool _isCoreFeaturesExpanded = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     myStateName = appData.read(kKeyMyState);
//     myId = appData.read(kKeyUserID);
//
//     print(">>>>>>>>>>>>>>>> in screen slug is ${widget.slug}");
//     print(">>>>>>>>>>>>>>>> in screen myId is $myId");
//     print(">>>>>>>>>>>>>>>> in screen myStateName is $myStateName");
//
//     // Initialize data
//     _initializeData();
//   }
//
//   Future<void> _initializeData() async {
//     // Fetch state information first
//     await fetchStates();
//
//     // Then fetch product details
//     await productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
//   }
//
//   Future<void> fetchStates() async {
//     try {
//       print("🟡 Starting fetchStates()...");
//       final StateDataModel? data = await getStateRx.getStateInfo();
//
//       if (data != null && data.data != null && data.data!.isNotEmpty) {
//         print("🔍 Looking for my state: '$myStateName'");
//
//         for (var item in data.data!) {
//           if (item.slug == myStateName) {
//             print("✅ FOUND MY STATE!");
//             print("Title: ${item.title}");
//             print("Percentage: ${item.percentage}");
//
//             setState(() {
//               stateName = item.title;
//               productPercentage = item.percentage?.toDouble() ?? 0.0;
//             });
//
//             print("Final productPercentage: $productPercentage");
//             break;
//           }
//         }
//       } else {
//         print("❌ No state data received");
//         setState(() {
//           productPercentage = 0.0;
//         });
//       }
//     } catch (e, stackTrace) {
//       print("❌ Fetch States Error caught:");
//       print("Error: $e");
//       print("Stack trace: $stackTrace");
//       log("Fetch States Error: $e");
//       log("Stack trace: $stackTrace");
//
//       setState(() {
//         productPercentage = 0.0;
//       });
//     }
//   }
//
//   double calculateTotalAmount(SaleData product) {
//     double productPrice =
//         double.tryParse(product.price?.toString() ?? '0') ?? 0.0;
//     double taxAmount = productPrice * (productPercentage) / 100;
//     double shippingCost = myShippingCost;
//
//     return productPrice + taxAmount + shippingCost;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: StreamBuilder<ProductDetailsDataModel>(
//           stream: productViewDetailsRx.dataFetcher,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                   UIHelper.verticalSpace(10.h),
//                   const Text(
//                     "Loading...",
//                     style: TextStyle(color: Colors.red),
//                   )
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               return const Center(child: Text("Something went wrong!"));
//             } else if (!snapshot.hasData || snapshot.data?.data == null) {
//               return const Center(child: Text("No data found."));
//             } else {
//               final data = snapshot.data!.data!;
//               productData = snapshot.data;
//
//               double productAmount =
//                   double.tryParse(data.price?.toString() ?? '0') ?? 0.0;
//               double taxAmount = productAmount * productPercentage / 100;
//               // myShippingCost = data?.shippingCost.;
//               double shippingAmount = myShippingCost;
//               double totalAmount = calculateTotalAmount(data);
//
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ProductImageSlider(
//                       image: data.productDetailsImages ?? [],
//                     ),
//                     Container(
//                       width: double.infinity,
//                       constraints: BoxConstraints(
//                         minHeight: MediaQuery.of(context).size.height * 0.6,
//                       ),
//                       decoration: const BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColor.cDCE4E6,
//                             blurRadius: 9.9,
//                             offset: Offset(0, 0.1),
//                           ),
//                         ],
//                         color: AppColor.whiteColor,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Product Name and Rating
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         data.title.toString(),
//                                         style: TextFontStyle
//                                             .textLine7w400cFFFFFFDmSans
//                                             .copyWith(
//                                           fontSize: 22.0,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 16.0),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16.0),
//                             Text(
//                               'Description',
//                               style: TextFontStyle.textLine7w400cFFFFFFDmSans
//                                   .copyWith(
//                                 fontSize: 16.0,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             // Description
//                             HtmlToWidgetRenderer(
//                               htmlData: data.description.toString(),
//                             ),
//                             const SizedBox(height: 16.0),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Core Feature',
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     fontSize: 16.0,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       _isCoreFeaturesExpanded =
//                                           !_isCoreFeaturesExpanded;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     _isCoreFeaturesExpanded
//                                         ? Icons.arrow_drop_up
//                                         : Icons.arrow_drop_down,
//                                     color: Colors.black,
//                                   ),
//                                 )
//                               ],
//                             ),
//
// // Add this section to show the properties when expanded
//                             if (_isCoreFeaturesExpanded &&
//                                 data.properties != null &&
//                                 data.properties!.isNotEmpty)
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ...data.properties!
//                                       .map((property) => Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 8.0),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   property.title ?? "Feature",
//                                                   style: TextStyle(
//                                                     fontSize: 14.0,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: Colors.grey[700],
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   property.value ?? "",
//                                                   style: TextStyle(
//                                                     fontSize: 14.0,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ))
//                                       .toList(),
//                                 ],
//                               )
//                             else if (_isCoreFeaturesExpanded)
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 8.0),
//                                 child: Text(
//                                   "No core features available",
//                                   style: TextStyle(
//                                     fontSize: 14.0,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ),
//
//                             Divider(
//                               color: Colors.black,
//                               thickness: 1.0,
//                             ),
//
//                             UIHelper.verticalSpace(10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Tax: ${stateName ?? "N/A"} (${productPercentage.toStringAsFixed(2)}%)',
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     fontSize: 14.0.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   '\$${taxAmount.toStringAsFixed(2)}',
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     fontSize: 14.0.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             UIHelper.verticalSpace(10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Shipping Price:',
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     fontSize: 14.0.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   '\$${shippingAmount.toStringAsFixed(2)}',
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     fontSize: 14.0.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             UIHelper.verticalSpace(10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'product Price:',
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     fontSize: 14.0.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   "\$${data.price?.toString() ?? "0.00"}",
//                                   style: TextFontStyle
//                                       .textLine7w400cFFFFFFDmSans
//                                       .copyWith(
//                                     fontSize: 14.0.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Divider(
//                               color: Colors.grey.withOpacity(0.5),
//                               thickness: 1.0,
//                             ),
//                             UIHelper.verticalSpace(20),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Total Price:',
//                                       style: TextFontStyle
//                                           .textLine7w400cFFFFFFDmSans
//                                           .copyWith(
//                                         fontSize: 12.0,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     Text(
//                                       '\$${totalAmount.toStringAsFixed(2)}',
//                                       style: TextFontStyle
//                                           .textLine7w400cFFFFFFDmSans
//                                           .copyWith(
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 isLoading
//                                     ? const CircularProgressIndicator(
//                                         color: Colors.blueAccent)
//                                     : CustomButton(
//                                         onTap: () {
//                                           setState(() {
//                                             _isProcessing = true;
//                                           });
//
//                                           postSaleProductPaymentRx
//                                               .saleProductStripePayment(
//                                                   productId: data.id);
//
//                                           setState(() {
//                                             _isProcessing = false;
//                                           });
//                                         },
//                                         text: _isProcessing
//                                             ? "Buying..."
//                                             : 'Buy Now',
//                                         context: context,
//                                         minWidth: 150,
//                                       ),
//                               ],
//                             ),
//                             UIHelper.verticalSpace(24.h),
//
//                             CustomButton(
//                               text: isWhiteListing
//                                   ? "Whitelisting..."
//                                   : data.bookmark.toString() == "true"
//                                       ? "Added to whitelist"
//                                       : "Add to whitelist",
//                               minWidth: double.infinity,
//                               color: Colors.white,
//                               onTap: () async {
//                                 setState(() {
//                                   isWhiteListing = true;
//                                 });
//
//                                 bool success = await postWhiteListRx
//                                     .postWhiteListApiInfo(productId: data.id);
//
//                                 if (success) {
//                                   await productViewDetailsRx
//                                       .categoryWiseProductData(
//                                           slug: widget.slug);
//                                 }
//
//                                 setState(() {
//                                   isWhiteListing = false;
//                                 });
//                               },
//                               textStyle: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 18,
//                               ),
//                               borderColor: Colors.black,
//                               context: context,
//                             ),
//
//                             // Contact Seller Button
//                             UIHelper.verticalSpace(24.h),
//                             myId != data.userId
//                                 ? CustomButton(
//                                     text: "Contact Seller",
//                                     minWidth: double.infinity,
//                                     textStyle: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 18,
//                                     ),
//                                     onTap: () {
//                                       print(
//                                           ">>>>>>>>>>>>>>>>>>>>> here is the my id $myId");
//                                       print(
//                                           ">>>>>>>>>>>>>>>>>>>>> here is the product user id ${data.userId}");
//
//                                       createConversationRx.createConversations(
//                                           userId: data.userId);
//                                     },
//                                     context: context)
//                                 : CustomButton(
//                                     text: "It's your product",
//                                     minWidth: double.infinity,
//                                     textStyle: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 18,
//                                     ),
//                                     onTap: () {
//                                       ToastUtil.showLongToast(
//                                           "It's your product");
//                                     },
//                                     context: context),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }












import 'dart:developer';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/user_app/products_screen/model/sale_product_details_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/widget/bit_product_image_slider.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/html_text_viewer.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';

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
  bool isLoading = false;
  ProductDetailsDataModel? productData;

  bool _isCoreFeaturesExpanded = false;

  @override
  void initState() {
    super.initState();

    myStateName = appData.read(kKeyMyState);
    myId = appData.read(kKeyUserID);

    print(">>>>>>>>>>>>>>>> in screen slug is ${widget.slug}");
    print(">>>>>>>>>>>>>>>> in screen myId is $myId");
    print(">>>>>>>>>>>>>>>> in screen myStateName is $myStateName");

    // Initialize data
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Fetch state information first
    await fetchStates();

    // Then fetch product details
    await productViewDetailsRx.categoryWiseProductData(slug: widget.slug);
  }

  Future<void> fetchStates() async {
    try {
      print("🟡 Starting fetchStates()...");
      final StateDataModel? data = await getStateRx.getStateInfo();

      if (data != null && data.data != null && data.data!.isNotEmpty) {
        print("🔍 Looking for my state: '$myStateName'");

        for (var item in data.data!) {
          if (item.slug == myStateName) {
            print("✅ FOUND MY STATE!");
            print("Title: ${item.title}");
            print("Percentage: ${item.percentage}");

            setState(() {
              stateName = item.title;
              productPercentage = item.percentage?.toDouble() ?? 0.0;
            });

            print("Final productPercentage: $productPercentage");
            break;
          }
        }
      } else {
        print("❌ No state data received");
        setState(() {
          productPercentage = 0.0;
        });
      }
    } catch (e, stackTrace) {
      print("❌ Fetch States Error caught:");
      print("Error: $e");
      print("Stack trace: $stackTrace");
      log("Fetch States Error: $e");
      log("Stack trace: $stackTrace");

      setState(() {
        productPercentage = 0.0;
      });
    }
  }

  double calculateTotalAmount(SaleData product) {
    double productPrice =
        double.tryParse(product.price?.toString() ?? '0') ?? 0.0;
    double taxAmount = productPrice * (productPercentage) / 100;
    double shippingCost = myShippingCost;

    return productPrice + taxAmount + shippingCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<ProductDetailsDataModel>(
          stream: productViewDetailsRx.dataFetcher,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  UIHelper.verticalSpace(10.h),
                  const Text(
                    "Loading...",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            } else if (!snapshot.hasData || snapshot.data?.data == null) {
              return const Center(child: Text("No data found."));
            } else {
              final data = snapshot.data!.data!;
              productData = snapshot.data;

              double productAmount =
                  double.tryParse(data.price?.toString() ?? '0') ?? 0.0;
              double taxAmount = productAmount * productPercentage / 100;
              myShippingCost = double.tryParse(data.shippingCost ?? '0') ?? 0.0;
              double shippingAmount = myShippingCost;
              double totalAmount = calculateTotalAmount(data);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageSlider(
                      image: data.productDetailsImages ?? [],
                    ),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.cDCE4E6,
                            blurRadius: 9.9,
                            offset: Offset(0, 0.1),
                          ),
                        ],
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title.toString(),
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 16.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Description',
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Description
                            HtmlToWidgetRenderer(
                              htmlData: data.description.toString(),
                            ),
                            const SizedBox(height: 16.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Core Feature',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCoreFeaturesExpanded =
                                      !_isCoreFeaturesExpanded;
                                    });
                                  },
                                  icon: Icon(
                                    _isCoreFeaturesExpanded
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),

// Add this section to show the properties when expanded
                            if (_isCoreFeaturesExpanded &&
                                data.properties != null &&
                                data.properties!.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...data.properties!
                                      .map((property) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          property.title ?? "Feature",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          property.value ?? "",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                      .toList(),
                                ],
                              )
                            else if (_isCoreFeaturesExpanded)
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "No core features available",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),

                            UIHelper.verticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax: ${stateName ?? "N/A"} (${productPercentage.toStringAsFixed(2)}%)',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$${taxAmount.toStringAsFixed(2)}',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            UIHelper.verticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Price:',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$${shippingAmount.toStringAsFixed(2)}',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),

                            UIHelper.verticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'product Price:',
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "\$${data.price?.toString() ?? "0.00"}",
                                  style: TextFontStyle
                                      .textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.5),
                              thickness: 1.0,
                            ),
                            UIHelper.verticalSpace(20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Price:',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '\$${totalAmount.toStringAsFixed(2)}',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                isLoading
                                    ? const CircularProgressIndicator(
                                    color: Colors.blueAccent)
                                    : CustomButton(
                                  onTap: () {
                                    setState(() {
                                      _isProcessing = true;
                                    });

                                    postSaleProductPaymentRx
                                        .saleProductStripePayment(
                                        productId: data.id);

                                    setState(() {
                                      _isProcessing = false;
                                    });
                                  },
                                  text: _isProcessing
                                      ? "Buying..."
                                      : 'Buy Now',
                                  context: context,
                                  minWidth: 150,
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(24.h),

                            CustomButton(
                              text: isWhiteListing
                                  ? "Whitelisting..."
                                  : data.bookmark.toString() == "true"
                                  ? "Added to whitelist"
                                  : "Add to whitelist",
                              minWidth: double.infinity,
                              color: Colors.white,
                              onTap: () async {
                                setState(() {
                                  isWhiteListing = true;
                                });

                                bool success = await postWhiteListRx
                                    .postWhiteListApiInfo(productId: data.id);

                                if (success) {
                                  await productViewDetailsRx
                                      .categoryWiseProductData(
                                      slug: widget.slug);
                                }

                                setState(() {
                                  isWhiteListing = false;
                                });
                              },
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                              borderColor: Colors.black,
                              context: context,
                            ),

                            // Contact Seller Button
                            UIHelper.verticalSpace(24.h),
                            myId != data.userId
                                ? CustomButton(
                                text: "Contact Seller",
                                minWidth: double.infinity,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                onTap: () {
                                  print(
                                      ">>>>>>>>>>>>>>>>>>>>> here is the my id $myId");
                                  print(
                                      ">>>>>>>>>>>>>>>>>>>>> here is the product user id ${data.userId}");

                                  createConversationRx.createConversations(
                                      userId: data.userId);
                                },
                                context: context)
                                : CustomButton(
                                text: "It's your product",
                                minWidth: double.infinity,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                onTap: () {
                                  ToastUtil.showLongToast(
                                      "It's your product");
                                },
                                context: context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}