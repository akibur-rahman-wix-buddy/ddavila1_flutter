import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/app_image.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/common_widgets/time_decriment_counter.dart';
import 'package:ddavila/constants/app_constants.dart';
import 'package:ddavila/helpers/di.dart';
import 'package:ddavila/helpers/toast.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'model/live_action_details_model.dart';

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
  bool timeFinished = false;
  dynamic myId = appData.read(kKeyUserID);




  @override
  void initState() {
    super.initState();
    _loadAuctionData();
    _initializePusher();

  }

  Future<void> _loadAuctionData() async {
    try {
      final result = await liveAuctionDetailsDataRx.liveAuctionDetailsDataInfo(
          slug: widget.slag);
      if (result != null && result.data != null) {
        setState(() {
          _currentProduct = result.data!;
          priceController.text = _currentProduct?.highestBid?.toString() ?? "0";
        });
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

      final myPublicChannel = _pusherClient!.publicChannel(
        "auction.${widget.productId}.bids",
      );

      _connectionSubs = _pusherClient!.onConnectionEstablished.listen((_) {
        log('Pusher connected successfully');
        myPublicChannel.subscribeIfNotUnsubscribed();
      });

      _channelEventSubs =
          myPublicChannel.bind("App\\Events\\BidPlaced").listen((event) {
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
                  final updatedBids = List<BidData>.from(currentModel.data!.bids ?? [])
                    ..insertAll(0, newBids);
                  final updatedHighestBid = newBids.isNotEmpty
                      ? newBids
                      .map((bid) => bid.amount ?? 0)
                      .reduce((a, b) => a > b ? a : b)
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
                      priceController.text =
                          _currentProduct!.highestBid?.toString() ?? "0";
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
    _connectionSubs?.cancel();
    _channelEventSubs?.cancel();
    _pusherClient?.disconnect();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: StreamBuilder<LiveAuctionDetailsApiDataModel>(
          stream: liveAuctionDetailsDataRx.dataFetcher,
          builder: (context, snapshot) {
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
              // Use the current product data
              final product = _currentProduct ?? snapshot.data!.data!;
              priceController.text = product.highestBid?.toString() ?? "0";

                  timeFinished = isTimeFinished(product.auctionEndAt.toString());


              return SingleChildScrollView(
                child: Column(
                    children: [
                ProductImageSlider(images: product.images ?? []),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.blackColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title ?? "",
                              style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                  .copyWith(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Row(
                              children: [
                                Icon(Icons.person,
                                    color: Colors.white70, size: 16.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.cDCE4E6,
                          blurRadius: 9.9,
                          offset: Offset(0, 0.1),
                        )
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
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.cF3F2F2),
                              borderRadius: BorderRadius.circular(12.0),
                              color: AppColor.cF3F2F2,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Starting Price',
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 14.0,
                                          color: AppColor.c000000,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$${product.startingPrice
                                            ?.toString() ?? "0"}',
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 12.0,
                                          color: AppColor.c000000,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(
                                                AppImages.showImage,
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            'are live',
                                            style: TextFontStyle
                                                .textLine7w400cFFFFFFDmSans
                                                .copyWith(
                                              fontSize: 12.0,
                                              color: AppColor.c000000,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Current Bid Price',
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 14.0,
                                          color: AppColor.c000000,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$${product.highestBid?.toString() ??
                                            "0"}',
                                        style: TextFontStyle
                                            .textLine7w400cFFFFFFDmSans
                                            .copyWith(
                                          fontSize: 12.0,
                                          color: AppColor.c000000,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: SvgPicture.asset(
                                                AppIcons.blueTimer,
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          StreamBuilder<String>(
                                            stream: getLiveCountdownStream(
                                                isoTime: product.auctionEndAt
                                                    ?.toString() ??
                                                    ""),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data ?? "Loading...",
                                                style: TextFontStyle
                                                    .textLine7w400cFFFFFFDmSans
                                                    .copyWith(
                                                  color: AppColor.c000000,
                                                  fontSize: 10,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Live Auction',
                                style: TextFontStyle
                                    .textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 14.0,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${product.bid?.toString() ?? "0"} Bids made',
                                style: TextFontStyle
                                    .textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  fontSize: 12.0,
                                  color: AppColor.c000000,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),







                          Text(timeFinished.toString()),






                          timeFinished == false ? Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Name and Rating
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    UIHelper.verticalSpace(
                                                      20,
                                                    ),
                                                    Image.asset(
                                                      AppImages.doneIcon,
                                                      height: 45,
                                                      width: 45,
                                                    ),
                                                    Text(
                                                      'Auction Closed',
                                                      style: TextFontStyle
                                                          .textLine7w400cFFFFFFDmSans
                                                          .copyWith(
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      'This auction has officially ended',
                                                      style: TextFontStyle
                                                          .textLine7w400cFFFFFFDmSans
                                                          .copyWith(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    UIHelper.verticalSpace(
                                                      10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                            BorderRadius.circular(8.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets.all(16),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'Winning Bid',
                                                                  style: TextFontStyle
                                                                      .textLine7w400cFFFFFFDmSans
                                                                      .copyWith(
                                                                    fontSize: 16.0,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                                UIHelper.verticalSpace(
                                                                  10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      AppImages.profile,
                                                                      height: 40,
                                                                      width: 40,
                                                                    ),
                                                                    UIHelper
                                                                        .horizontalSpace(
                                                                      10,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                      product.bids?.first.user?.name??"",
                                                                          style: TextFontStyle
                                                                              .textLine7w400cFFFFFFDmSans
                                                                              .copyWith(
                                                                            fontSize: 16.0,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color: Colors
                                                                                .black,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Winning Bidder',
                                                                          style: TextFontStyle
                                                                              .textLine7w400cFFFFFFDmSans
                                                                              .copyWith(
                                                                            fontSize: 12.0,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                            color:
                                                                            Colors.grey,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                UIHelper.verticalSpace(
                                                                  10,
                                                                ),
                                                                UIHelper.verticalSpace(
                                                                  10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal: 16.0),
                                                                  child: Container(
                                                                    width: double.infinity,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors.green
                                                                          .withOpacity(
                                                                        0.1,
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                        8.0,
                                                                      ),
                                                                    ),
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .all(16),
                                                                      child: Column(
                                                                        children: [
                                                                          Text(
                                                                            'Final Price',
                                                                            style: TextFontStyle
                                                                                .textLine7w400cFFFFFFDmSans
                                                                                .copyWith(
                                                                              fontSize:
                                                                              12.0.sp,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              color: Colors
                                                                                  .black,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '\$${product.bids?.first.amount.toString()??"0"}',
                                                                            style: TextFontStyle
                                                                                .textLine7w400cFFFFFFDmSans
                                                                                .copyWith(
                                                                              fontSize:
                                                                              12.0.sp,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              color: Colors
                                                                                  .black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    UIHelper.verticalSpace(
                                                      20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              UIHelper.verticalSpace(
                                                20,
                                              ),
                                              // Text(
                                              //   'Axel Arigato',
                                              //   style: TextFontStyle
                                              //       .textLine7w400cFFFFFFDmSans
                                              //       .copyWith(
                                              //     fontSize: 22.0,
                                              //     fontWeight: FontWeight.bold,
                                              //     color: Colors.black,
                                              //   ),
                                              // ),
                                              // SizedBox(height: 4),
                                              // Text(
                                              //   'FREE SHIPPING! FREE RETURNS! View Store For Coupons!',
                                              //   style: TextFontStyle
                                              //       .textLine7w400cFFFFFFDmSans
                                              //       .copyWith(
                                              //     fontSize: 14.0.sp,
                                              //     fontWeight: FontWeight.bold,
                                              //     color: Colors.black,
                                              //   ),
                                              //   softWrap: true,
                                              // ),
                                              // SizedBox(height: 4.0),
                                              // Row(
                                              //   children: [
                                              //     Icon(Icons.star,
                                              //         color: Colors.yellow, size: 18.0),
                                              //     Icon(Icons.star,
                                              //         color: Colors.yellow, size: 18.0),
                                              //     Icon(Icons.star,
                                              //         color: Colors.yellow, size: 18.0),
                                              //     Icon(Icons.star,
                                              //         color: Colors.yellow, size: 18.0),
                                              //     Icon(Icons.star_border,
                                              //         color: Colors.yellow, size: 18.0),
                                              //     SizedBox(width: 5.0),
                                              //     Text(
                                              //       '(270 Review)',
                                              //       style: TextFontStyle
                                              //           .textLine7w400cFFFFFFDmSans
                                              //           .copyWith(
                                              //         fontSize: 14.0,
                                              //         color: Colors.grey,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 16.0),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    
                                  product.userId == myId? SizedBox():  CustomButton(
                                     onTap: ()  {

                              createConversationRx.createConversations(userId: product.userId);
                              },

                                      text: "Contact to seller ", context: context,minWidth: double.infinity,),
                                    // Text(
                                    //   'Description',
                                    //   style:
                                    //   TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                    //     fontSize: 16.0,
                                    //     color: Colors.black,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                    // SizedBox(height: 16.0),
                                    // Text(
                                    //   'Engineered to crush any movement-based workout, these On sneakers enhance the label\'s original Cloud sneaker with cutting-edge technologies for a pair.',
                                    //   style:
                                    //   TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                                    //     fontSize: 12.0,
                                    //     color: Colors.black.withOpacity(
                                    //       0.7,
                                    //     ),
                                    //   ),
                                    // ),
                                    UIHelper.verticalSpace(
                                      20,
                                    ),
                                    // * Pricing List
                                    product.userId == myId ?  Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Price:- ',
                                              style: TextFontStyle
                                                  .textLine7w400cFFFFFFDmSans
                                                  .copyWith(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '\$245.00',
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
                                        UIHelper.verticalSpace(
                                          10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tax:- ',
                                              style: TextFontStyle
                                                  .textLine7w400cFFFFFFDmSans
                                                  .copyWith(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '\$245.00',
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
                                        UIHelper.verticalSpace(
                                          10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Shipping Price:- ',
                                              style: TextFontStyle
                                                  .textLine7w400cFFFFFFDmSans
                                                  .copyWith(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '\$245.00',
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
                                        UIHelper.verticalSpace(
                                          10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Price:- ',
                                              style: TextFontStyle
                                                  .textLine7w400cFFFFFFDmSans
                                                  .copyWith(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '\$245.00',
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
                                        UIHelper.verticalSpace(
                                          20,
                                        ),

                                        CustomButton(
                                          onTap: (){
                                            print(">>>>>>>>>>>>>>>>>>>>>>> here is the bit id ${product.bids?.first.id}");
                                          },
                                          minWidth: double.infinity,
                                          text: 'Proceed To Payment',
                                          context: context,
                                        )
                                      ],
                                    ):SizedBox(),


                                    UIHelper.verticalSpace(100)
                                  ],
                                ),
                              ),
                            ),
                          ):


                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: product.bids?.length ?? 0,
                              itemBuilder: (context, index) {
                                return BiddingPeopleList(
                                  type:product.bids?[index].user?.email.toString()??"",
                                  image:
                                  product.bids![index].user?.avatar.toString() ?? "",
                                  name: product.bids![index].user?.name ?? "",
                                  value: product.bids![index].amount
                                      ?.toString() ??
                                      "0",
                                );
                              },
                            ),
                          )
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

      floatingActionButton:

      timeFinished == true ?

      isLoading? Container(
        margin: EdgeInsets.only(left: 16,right: 16,bottom: 10),
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.c4275f6,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color:AppColor.c4275f6,
            width: 1.5
          )
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ): Container(
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
              child: isLoading
                  ? const CircularProgressIndicator(
                color: Colors.blue,
              )
                  : CustomButton(
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
      ): SizedBox(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BiddingPeopleList extends StatelessWidget {
  final String image;
  final String name;
  final String value;
  final String type;

  const BiddingPeopleList({
    super.key,
    required this.image,
    required this.name,
    required this.value,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                height: 40,
                width: 40,
                image_url + image.toString() ,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error_outline, color: Colors.red),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 14.0,
                  color: AppColor.c000000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                type,
                style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                  fontSize: 12.0,
                  color: AppColor.c000000,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            '\$$value',
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              fontSize: 14.0,
              color: AppColor.c000000,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImageSlider extends StatefulWidget {
  final List<String> images;

  const ProductImageSlider({super.key, required this.images});

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image_url + widget.images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 90,
                        height: 90,
                        color: Colors.grey[200],
                        child:
                        const Icon(Icons.error_outline, color: Colors.red),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 10.0,
            left: 16.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(AppIcons.arrowBack),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 16.0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AppIcons.cartIcon,
                  height: 44.0,
                  width: 44.0,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                    (index) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.5,
                      color: _currentIndex == index
                          ? Colors.red
                          : Colors.transparent,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      height: _currentIndex == index ? 10.0 : 6.0,
                      width: _currentIndex == index ? 10.0 : 6.0,
                      decoration: BoxDecoration(
                        color:
                        _currentIndex == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}