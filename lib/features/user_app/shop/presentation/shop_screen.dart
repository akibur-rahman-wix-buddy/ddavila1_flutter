// ignore_for_file: avoid_print, sized_box_for_whitespace, library_private_types_in_public_api

import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/complete_account_info_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/card_add_in_stripe.dart';
import 'package:ddavila/features/user_app/shop/model/shop_all_products.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<ShopAllProductsDataModel?> shopDataFuture;
  int currentPage = 1;
  late Timer _timer;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  List<Product> allProducts = [];
  final Map<int, bool> _isProcessingMap =
      {}; // Map to track loading state for each product
  bool isStripeConnected = appData.read(kKeyCardAttributes);
  bool isProfileConnected = appData.read(kKeyOnboarding);
  bool? isLikeFromApi;
  final Map<int, bool> _likeStates = {};

  @override
  void initState() {
    super.initState();
    shopDataFuture = getShopData(currentPage);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {}); // Trigger rebuild every second
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !isLoadingMore) {
        loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<ShopAllProductsDataModel?> getShopData(int pageNumber) async {
    return await getShopRx.getShopData(pageNumber: pageNumber);
  }

  void loadMoreData() async {
    if (isLoadingMore) return;
    setState(() {
      isLoadingMore = true;
    });
    final data = await getShopData(currentPage + 1);
    if (data?.data?.products != null && data!.data!.products!.isNotEmpty) {
      setState(() {
        currentPage++;
        allProducts.addAll(data.data!.products!);
        isLoadingMore = false;
      });
    } else {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  String calculateTimeLeft(String endTime) {
    final end = DateTime.parse(endTime).toLocal();
    final now = DateTime.now();
    Duration remaining = end.difference(now);

    if (remaining.isNegative) return '0d 00h 00m 00s';

    remaining -= const Duration(seconds: 1);

    final days = remaining.inDays;
    final hours = remaining.inHours.remainder(24);
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);

    return '$days d ${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
  }

  Widget _buildSearchField() {
    return GestureDetector(
      onTap: () => NavigationService.navigateTo(Routes.searchScreen),
      child: CustomTextField(
        borderRadius: 58,
        hintText: 'Search...',
        isEnabled: false,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(AppIcons.searchIcon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: const Text('Shop'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<ShopAllProductsDataModel?>(
        future: shopDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              allProducts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          if (allProducts.isEmpty) {
            allProducts = snapshot.data!.data?.products ?? [];

          }

          return SafeArea(
            child: Column(
              children: [
                UIHelper.verticalSpace(20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildSearchField()),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(Routes.filterScreen);
                          },
                          child: SvgPicture.asset(AppIcons.filterIcon),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 100/170,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: allProducts.length + (isLoadingMore ? 2 : 0),
                    itemBuilder: (context, index) {
                      if (index >= allProducts.length) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              color: Colors.white,
                              height: 120,
                            ),
                          ),
                        );
                      }

                      final product = allProducts[index];
                      final isAuction = product.type == 'auction';
                      final isSale = product.type == 'sale';
                      final isTimeOver = product.auctionEndAt != null &&
                          DateTime.parse(product.auctionEndAt!)
                              .toLocal()
                              .isBefore(DateTime.now());
                      final isProcessing =
                          _isProcessingMap[product.id] ?? false;


                      if (allProducts.isEmpty) {
                        allProducts = snapshot.data!.data?.products ?? [];
                        // Initialize like states when data is first loaded
                        for (var product in allProducts) {
                          if (product.id != null) {
                            _likeStates[product.id!] = product.bookmark ?? false;
                          }
                        }
                      }

                      return GestureDetector(
                        onTap: () {
                          print(
                              ">>>>>>>>>>>>>>> here is the product type  after ${product.type}");
                          if (product.type.toString() == "sale") {
                            print(
                                ">>>>>>>>>>>>>>>>>>> here is the  stripe connected value ${isStripeConnected}");
                            if (isStripeConnected == true && isProfileConnected == true) {
                              NavigationService.navigateToWithArgs(
                                Routes.productDetailsScreen,
                                {
                                  "slug": product.slug,
                                },
                              );
                            } else if (isStripeConnected == false) {
                              Get.to(StripeCardScreen());
                            } else if (isProfileConnected == false) {
                              Get.to(CompleteAccountInfoScreen());
                            }

                            print(">>>>>>>>>>>>>>> here is the product id ${product.id}");
                            print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
                            // NavigationService.navigateToWithArgs(
                            //   Routes.productDetailsScreen,
                            //   {"slug": product.slug},
                            // );
                          } else if (product.type.toString() == "auction") {
                            print(">>>>>>>>>>>>>>>>>>> this is the else product ");

                            print(
                                ">>>>>>>>>>>>>>>>>>> here is the  stripe connected value ${isStripeConnected}");
                            if (isStripeConnected == true && isProfileConnected == true) {
                              NavigationService.navigateToWithArgs(
                                Routes.productsBidScreen,
                                {"slag": product.slug, "productId": product.id},
                              );
                            } else if (isProfileConnected == false) {
                              Get.to(CompleteAccountInfoScreen());
                            } else if (isStripeConnected == false) {
                              Get.to(StripeCardScreen());
                            }

                            print(">>>>>>>>>>>>>>> here is the product type ${product.type}");
                            print(
                                ">>>>>>>>>>>>>>> here is the not sale , and this is id product id ${product.id}");
                            // NavigationService.navigateToWithArgs(
                            //   Routes.productsBidScreen,
                            //   {"slag": product.slug, "productId": product..id},
                            // );
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  "$image_url${product.firstImage}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 120,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                          height: 120,
                                          child:  Image.asset(AppImages.placeholder)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 130.w,
                                              child: Text(
                                                product.title ?? '',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            if (isSale && product.price != null)
                                              SizedBox(
                                                width: 130.w,
                                                child: Text(overflow: TextOverflow.ellipsis,'Price \$${product.price}',
                                                    style: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (product.id == null) return;

                                            final productId = product.id!;
                                            final currentState = _likeStates[productId] ?? false;
                                            final newState = !currentState;

                                            // IMMEDIATE UI CHANGE
                                            setState(() {
                                              _likeStates[productId] = newState;
                                            });

                                            try {
                                              await postWhiteListRx.postWhiteListApiInfo(productId: productId);
                                              // Success - state is already updated
                                            } catch (error) {
                                              // If API fails, revert the UI change
                                              if (mounted) {
                                                setState(() {
                                                  _likeStates[productId] = currentState;
                                                });
                                              }
                                              print('API Error: $error');
                                              // Optional: Show error message to user
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Failed to update bookmark: $error')),
                                              );
                                            }
                                          },
                                          child: Icon(
                                            (_likeStates[product.id ?? 0] ?? false) ? Icons.favorite : Icons.favorite_border,
                                            color: (_likeStates[product.id ?? 0] ?? false) ? Colors.red : Colors.black,
                                            size: 25,
                                          ),
                                        )
                                      ],
                                    ),
                                 
                                    
                                    
                                    
                                    
                                    if (isAuction && product.highestBid != null)
                                      Text(
                                          'Current Bid \$${product.highestBid}',
                                          style: const TextStyle(
                                              color: Colors.green)),
                                    if (product.shippingCost != null)
                                      Text('Ship \$${product.shippingCost}'),
                                    if (isAuction &&
                                        !isTimeOver &&
                                        product.auctionEndAt != null)
                                      Text(
                                        'Ends in: ${calculateTimeLeft(product.auctionEndAt!)}',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    if (
                                        product.auctionEndAt == null)
                                      Text("Available",style: TextStyle(color: Colors.green),),
                                    if (isTimeOver)
                                      Text("Finished bids",style: TextStyle(color: Colors.blueGrey),),

                                    Text(
                                        isTimeOver
                                            ? 'Status: TIME OVER'
                                            : 'Status: Running',
                                        style:
                                             TextStyle( color:isTimeOver ? Colors.red: Colors.green)),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (isSale && product.price != null) {
                                          if (product.id != null) {
                                            // Check if product.id is not null
                                            setState(() {
                                              _isProcessingMap[product.id!] =
                                                  true;
                                            });
                                            await postSaleProductPaymentRx
                                                .saleProductStripePayment(
                                                    productId: product.id!);
                                            setState(() {
                                              _isProcessingMap[product.id!] =
                                                  false;
                                            });
                                          }
                                        } else if (isAuction && !isTimeOver) {
                                          NavigationService.navigateToWithArgs(
                                            Routes.productsBidScreen,
                                            {
                                              "slag": product.slug,
                                              "productId": product.id
                                            },
                                          );
                                        } else if (isTimeOver) {
                                          NavigationService.navigateToWithArgs(
                                            Routes.productsBidScreen,
                                            {
                                              "slag": product.slug,
                                              "productId": product.id
                                            },
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isTimeOver
                                            ? Colors.grey
                                            : Colors.blue,
                                        minimumSize:
                                            const Size(double.infinity, 36),
                                      ),
                                      child: isProcessing
                                          ? SizedBox(
                                              width: 25,
                                              height: 25,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              isSale
                                                  ? 'Buy Now'
                                                  : isAuction && !isTimeOver
                                                      ? 'Quick Bid'
                                                      : 'View Results',
                                            ),
                                    ),

                                    //  Text(
                                    //   isSale ?'✨ This product is on sale! Grab it before it\'s gone.':isAuction?"🔥 Auction live—place your bid now before time runs out!":"🔒 Auction finished—stay tuned for the next one!",
                                    //   style: TextStyle(color: Colors.green),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
