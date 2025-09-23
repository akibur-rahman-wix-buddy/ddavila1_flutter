// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/features/user_app/products_screen/model/state_data_model.dart';
import 'package:ddavila/features/user_app/products_screen/widget/bit_auction_details_container.dart';
import 'package:ddavila/features/user_app/products_screen/widget/bit_product_header_section.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../model/live_action_details_model.dart';
import '../widget/product_image_slider.dart';

class ProductsBidScreen extends StatefulWidget {

  final dynamic slag;
  final dynamic productId;

  const ProductsBidScreen({

    super.key,
    required this.slag,
    required this.productId,

  });

  @override
  State<ProductsBidScreen> createState() => _ProductsBidScreenState();
}

class _ProductsBidScreenState extends State<ProductsBidScreen> {
  PusherChannelsClient? _pusherClient;
  TextEditingController priceController = TextEditingController();
  StreamSubscription? _connectionSubs;
  StreamSubscription<ChannelReadEvent>? _channelEventSubs;
  ProductData? _currentProduct;
  bool isLoading = false;
  bool? timeFinished;
  Timer? _timer;
  dynamic myId = appData.read(kKeyUserID);
  dynamic productPercentage;
  dynamic stateName;
  dynamic myStateName = appData.read(kKeyMyState);
  dynamic myShippingCost;


  bool isTimeFinished(String dateTimeString) {
    if (dateTimeString.isEmpty) return false;
    try {
      DateTime auctionEndTime = DateTime.parse(dateTimeString).toUtc();
      DateTime now = DateTime.now().toUtc();
      return now.isAfter(auctionEndTime);
    } catch (e) {
      return false;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted && _currentProduct != null && _currentProduct!.auctionEndAt != null) {
        setState(() {
          timeFinished = isTimeFinished(_currentProduct!.auctionEndAt.toString());
        });
      }
    });
  }

  @override
  void initState() {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>> here is my id ${myId}");
    super.initState();
    _loadAuctionData();
    _initializePusher();
    getStateRx.getStateInfo();
    fetchStates();
  }

  Future<StateDataModel?> fetchStates() async {
    try {
      print("🟡 Starting fetchStates()...");
      final data = await getStateRx.getStateInfo();

      print("🔵 Raw API response received");
      print("Data type: ${data.runtimeType}");
      print("Is data null? ${data == null}");

      if (data != null) {
        print("📊 Data structure:");
        print("- Data model: ${data.runtimeType}");
        print("- Has data field? ${data.data != null}");
        print("- Data field type: ${data.data?.runtimeType}");
        print("- Data field length: ${data.data?.length ?? 0}");

        if (data.data != null && data.data!.isNotEmpty) {
          print("\n📋 All states received:");
          for (var i = 0; i < data.data!.length; i++) {
            final item = data.data![i];
            print("--- Item $i ---");
            print("Slug: '${item.slug}' (type: ${item.slug.runtimeType})");
            print("Title: '${item.title}' (type: ${item.title.runtimeType})");
            print("Percentage: ${item.percentage} (type: ${item.percentage?.runtimeType})");
            print("My state name: '$myStateName' (type: ${myStateName.runtimeType})");
            print("Match? ${item.slug == myStateName}");
            print("----------------");
          }

          print("\n🔍 Looking for my state: '$myStateName'");
          var found = false;

          for (var item in data.data!) {
            if (item.slug == myStateName) {
              print("✅ FOUND MY STATE!");
              print("Title: ${item.title}");
              print("Percentage: ${item.percentage}");

              stateName = item.title;
              productPercentage = (item.percentage); // Safe null handling

              print("Final productPercentage: $productPercentage");
              found = true;
              break;
            }
          }

          if (!found) {
            print("❌ State '$myStateName' not found in the list");
            print("Available slugs: ${data.data!.map((e) => e.slug).toList()}");
            productPercentage = 0.0 as Double?; // Default value if not found
          }
        } else {
          print("❌ data.data is null or empty");
          productPercentage = 0.0 as Double?; // Default value
        }
      } else {
        print("❌ Entire data response is null");
        productPercentage = 0.0 as Double?; // Default value
      }

      return data;
    } catch (e, stackTrace) {
      print("❌ Fetch States Error caught:");
      print("Error: $e");
      print("Stack trace: $stackTrace");
      log("Fetch States Error: $e");
      log("Stack trace: $stackTrace");
      productPercentage = 0.0 as Double?; // Default value on error
      return null;
    }
  }



  double safeDivide(dynamic numerator, dynamic denominator) {
    double numValue = 0;
    double denomValue = 1; // avoid division by zero

    if (numerator != null) {
      numValue = double.tryParse(numerator.toString()) ?? 0;
    }

    if (denominator != null) {
      denomValue = double.tryParse(denominator.toString()) ?? 1;
    }

    return numValue / denomValue;
  }

  Future<void> _loadAuctionData() async {
    try {
      final result = await liveAuctionDetailsDataRx.liveAuctionDetailsDataInfo(slug: widget.slag);
      if (result != null && result.data != null) {
        setState(() {
          _currentProduct = result.data!;
          priceController.text = _currentProduct?.highestBid?.toString() ?? "0";
          timeFinished = isTimeFinished(_currentProduct!.auctionEndAt.toString());
        });
        _startTimer(); // Start timer after data is loaded
      } else {
        if (mounted) {
          ToastUtil.showShortToast("No auction data available");
        }
      }
    } catch (e, stack) {
      log("Error loading auction data: $e", error: stack);
      if (mounted) {
        ToastUtil.showShortToast("Failed to load auction data");
      }
    }
  }

  void _initializePusher() {
    try {
      const hostOptions = PusherChannelsOptions.fromHost(
        scheme: 'wss',
        host: 'app.thehobbynexus.com',
        key: '5bcus2pmxhiwlo28uzz3',
        shouldSupplyMetadataQueries: true,
        metadata: PusherChannelsOptionsMetadata.byDefault(),
        port: 8083,
      );

      _pusherClient = PusherChannelsClient.websocket(
        options: hostOptions,
        connectionErrorHandler: (exception, trace, refresh) async {
          log("Connection error: $exception", error: trace);
          await Future.delayed(const Duration(seconds: 2));
          refresh();
        },
      );

      final myPublicChannel = _pusherClient!.publicChannel("auction.${widget.productId}.bids");

      _connectionSubs = _pusherClient!.onConnectionEstablished.listen((_) {
        log('Pusher connected successfully');
        myPublicChannel.subscribeIfNotUnsubscribed();
      });

      _channelEventSubs = myPublicChannel.bind("App\\Events\\BidPlaced").listen((event) {
        log("Pusher event data: ${event.data}");

        try {
          if (event.data != null) {
            final Map<String, dynamic> eventData = json.decode(event.data);
            final List<dynamic>? topBids = eventData['top_bids'];

            if (topBids == null || topBids.isEmpty) {
              log("No top_bids found in event data");
              return;
            }

            // Convert top_bids to List<BidData>
            final List<BidData> newBids = topBids.map((bidJson) {
              return BidData.fromJson(bidJson as Map<String, dynamic>);
            }).toList();

            final currentModel = liveAuctionDetailsDataRx.dataFetcher.value;
            if (currentModel.data != null) {
              // Update bids and highest bid
              final updatedBids = List<BidData>.from(currentModel.data!.bids ?? [])..insertAll(0, newBids);
              final updatedHighestBid = newBids.isNotEmpty
                  ? newBids.map((bid) => bid.amount ?? 0).reduce((a, b) => a > b ? a : b)
                  : currentModel.data!.highestBid;

              final updatedProduct = currentModel.data!.copyWith(
                bids: updatedBids,
                highestBid: updatedHighestBid,
                bid: (currentModel.data!.bid ?? 0) + newBids.length,
              );

              liveAuctionDetailsDataRx.dataFetcher.add(
                LiveAuctionDetailsApiDataModel(
                  success: currentModel.success,
                  message: currentModel.message,
                  code: currentModel.code,
                  data: updatedProduct,
                ),
              );

              if (mounted) {
                setState(() {
                  _currentProduct = updatedProduct;
                  priceController.text = _currentProduct!.highestBid?.toString() ?? "0";
                });
              }
            }
          }
        } catch (e, stack) {
          log("Error in pusher event handling: $e", error: stack);
          if (mounted) {
            ToastUtil.showShortToast("Error processing bid update");
          }
        }
      });

      _pusherClient!.connect();
    } catch (e, stack) {
      log("Pusher initialization failed: $e", error: stack);
      if (mounted) {
        ToastUtil.showShortToast("Failed to initialize real-time connection");
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _connectionSubs?.cancel();
    _channelEventSubs?.cancel();
    _pusherClient?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: StreamBuilder<bool>(
            stream: liveAuctionDetailsDataRx.isLoadingStream,
            builder: (context, loadingSnapshot) {
              return StreamBuilder<LiveAuctionDetailsApiDataModel>(
                stream: liveAuctionDetailsDataRx.dataFetcher,
                builder: (context, snapshot) {
                  // Show shimmer when loading
                  if (loadingSnapshot.data == true) {
                    return _buildShimmerLoading();
                  }

                  // Original logic for other states
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        UIHelper.verticalSpace(10.h),
                        const Text("Loading...", style: TextStyle(color: Colors.red))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong!"));
                  } else if (!snapshot.hasData || snapshot.data?.data == null) {
                    return const Center(child: Text("No data found."));
                  } else {
                  BidData? winningBit;

                  myShippingCost = snapshot.data?.data?.shippingCost;


                  /// >>>>>>>>>>>>>>>>>>> if first bit then use this >>>>>>>>>>>>>



                  if(_currentProduct?.bids != null && _currentProduct!.bids!.isNotEmpty) {
                    winningBit = _currentProduct?.bids?.first;
                  }
                  /// >>>>>>>>>>>>>>>>>>> if winner bit then use this >>>>>>>>>>>>>
                  // if (_currentProduct?.bids != null && _currentProduct!.bids!.isNotEmpty) {
                  //   for (var item in _currentProduct!.bids!) {
                  //     if (item.isWinner == 1) {
                  //       winningBit = item;
                  //       print("✅ Winner found! User: ${item.user?.name}");
                  //       print("✅ Winner found! User id: ${item.user?.id}");
                  //     }
                  //   }
                  // }
                  final product = _currentProduct ?? snapshot.data!.data!;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageSlider(images: product.images ?? []),
                        ProductHeader(product: product),
                        AuctionDetailsContainer(
                          product: product,
                          timeFinished: timeFinished,
                          winningBit: winningBit,
                          myId: myId,
                          myShippingCost: myShippingCost,
                          productPercentage: productPercentage,
                          stateName: stateName,
                        ),
                        UIHelper.verticalSpace(100.h)
                      ],
                    ),
                  );
                }
              },
            );
          }
        ),
      ),
      floatingActionButton: timeFinished == false ? _buildBidButton() : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }



  // Shimmer effect widget
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





  Widget _buildBidButton() {
    return isLoading
        ? Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.c4275f6,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: AppColor.c4275f6, width: 1.5),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    )
        : Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 130.h,
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextField(controller: priceController),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomButton(
              onTap: () async {
                setState(() => isLoading = true);
                try {
                  await postBitRx.postBitInfo(
                    price: priceController.text,
                    id: widget.productId,
                  );
                } catch (e) {
                  debugPrint("Error placing bid: $e");
                } finally {
                  setState(() => isLoading = false);
                }
              },
              minWidth: double.infinity,
              text: 'Place Bid',
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}





class PaymentDetails extends StatefulWidget {
  final BidData product;
  final dynamic myShippingCost;
  final dynamic productPercentage;
  final dynamic stateName;

  const PaymentDetails({
    super.key,
    required this.product,
    required this.myShippingCost,
    required this.productPercentage,
    required this.stateName,
  });

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  bool paymentIsLoading= false;
  double calculateTotalAmount(BidData product) {
    // Convert string amount to double first
    double productPrice = double.tryParse(product.amount?.toString() ?? '0') ?? 0.0;
    double taxAmount = productPrice * (widget.productPercentage ?? 0.0) / 100;
    double shippingCost = double.tryParse(widget.myShippingCost?.toString() ?? '0') ?? 0.0;

    return productPrice + taxAmount + shippingCost;
  }

  @override
  Widget build(BuildContext context) {
    // Convert string amount to double first
    double productAmount = double.tryParse(widget.product.amount?.toString() ?? '0') ?? 0.0;
    double taxAmount = productAmount * (widget.productPercentage ?? 0.0) / 100;
    double shippingAmount = double.tryParse(widget.myShippingCost?.toString() ?? '0') ?? 0.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price:- ',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '\$${productAmount.toStringAsFixed(2)}',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
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
              'Tax: ${widget.stateName} ${"(${widget.productPercentage??0.00} %)"} ',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '\$${taxAmount.toStringAsFixed(2)}',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
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
              'Shipping Price:- ',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '\$${shippingAmount.toStringAsFixed(2)}',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
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
        UIHelper.verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price:- ',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '\$${calculateTotalAmount(widget.product).toStringAsFixed(2)}',
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(20),

        paymentIsLoading ?CircularProgressIndicator(color: Colors.blueAccent,):

        CustomButton(
          onTap: () async {
            setState(() {
              paymentIsLoading= true;
            });

            bool success = await bitPaymentRx.bitPaymentInfo(bitId: widget.product.id);
            setState(() {
              paymentIsLoading = false;
            });
            print(">>>>>>>>>>>>>>>>>>>>>>> here is the bit id ${widget.product.id}");
          },
          minWidth: double.infinity,
          text: 'Proceed To Payment',
          context: context,
        )
      ],
    );
  }
}
