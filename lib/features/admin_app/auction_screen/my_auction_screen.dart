import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/auction_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/auction_running_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/widget/auction_complete.dart';
import 'package:ddavila/features/admin_app/auction_screen/widget/auction_running.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key, this.isBack});
  final bool? isBack;

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  int selectedIndex = 0;
  var ongoingMaxPage = 1;
  var completeMaxPage = 1;

  int ongoingCurrentPage = 1;
  int completeCurrentPage = 1;

  @override
  void initState() {
    auctionOngoingApiRxObj.getAuctionOngoing(ongoingCurrentPage);
    auctionCompleteApiRxObj.getAuctionComplete(completeCurrentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              widget.isBack == true
                  ? Row(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: IconButton(
                                onPressed: () {
                                  NavigationService.goBack;
                                },
                                icon: Icon(Icons.arrow_back))),
                        Text(
                          "My Auction ",
                          style: TextFontStyle.textLine16w500cFFFFFFLato
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox()
                      ],
                    )
                  : SizedBox(),
              Container(
                height: 50,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _buildTab("On Going", 0),
                    _buildTab("Completed", 1),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              /// Auction List
              Expanded(
                child: selectedIndex == 1
                    ? StreamBuilder<AuctionModel>(
                        stream: auctionCompleteApiRxObj.dataFetcher,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          if (!snapshot.hasData ||
                              snapshot.data?.data == null ||
                              (snapshot.data?.data?.data?.isEmpty ?? true)) {
                            return const Center(
                                child: Text('No Product available'));
                          }
                          completeMaxPage = snapshot.data?.data?.lastPage ?? 1;

                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.data?.data?.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final value =
                                        snapshot.data?.data?.data?[index];

                                    return AuctionCompleteView(
                                      id: value?.id ?? 0,
                                      slug: value?.slug ?? "",
                                      price: value?.highestBid ?? 00,
                                      title: value?.title,
                                      image:
                                          value?.images?.first.toString() ?? "",
                                      endDate: value?.auctionEndAt,
                                      winner:
                                          value?.winner?.name ?? "No Winner",
                                    );
                                  },
                                ),
                              ),

                              /// Pagination
                              _buildPagination(
                                completeCurrentPage,
                                completeMaxPage,
                                (page) {
                                  setState(() => completeCurrentPage = page);
                                  auctionCompleteApiRxObj
                                      .getAuctionComplete(page);
                                },
                              )
                            ],
                          );
                        })
                    : StreamBuilder<AuctionRunningModel>(
                        stream: auctionOngoingApiRxObj.dataFetcher,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          if (!snapshot.hasData ||
                              snapshot.data?.data == null ||
                              (snapshot.data?.data?.items?.isEmpty ?? true)) {
                            return const Center(
                                child: Text('No Product available'));
                          }

                          ongoingMaxPage = snapshot.data?.data?.lastPage ?? 1;
                          final items = snapshot.data?.data?.items;

                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: items?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final value = items?[index];

                                    return GestureDetector(
                                      onTap: (){

                                          NavigationService.navigateToWithArgs(
                                              Routes.productsBidScreen, {
                                            "productId": value?.id.toString(),
                                            "slag": value?.slug.toString(),
                                          });
                                      },
                                      child: AuctionRunningView(
                                        currentBid: (value?.highestBid != null &&
                                                value!.highestBid != 0)
                                            ? value.highestBid
                                            : (value?.startingPrice != null &&
                                                    value!.startingPrice != 0)
                                                ? value.startingPrice
                                                : 0,
                                        title: value?.title,
                                        image:
                                            value?.images?.first.toString() ?? "",
                                        timeLeft: value?.auctionEndAt,

                                        // * Edit purpose
                                        price: value?.price.toString() ?? 0,
                                        type: value?.type.toString() ?? "",
                                        shipping_cost:
                                            value?.shippingCost.toString() ?? 0,
                                        ship_within:
                                            value?.shipWithin.toString() ?? "",
                                        auction_end_at:
                                            value?.auctionEndAt.toString() ?? "",
                                        starting_price:
                                            value?.startingPrice.toString() ?? 0,
                                        imagesList: value?.images ?? [],
                                        category_id:
                                            value?.categoryId.toString() ?? 0,
                                        sub_category_id:
                                            value?.subCategoryId.toString() ?? 0,
                                        id: value?.id.toString() ?? 0,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              /// Pagination
                              _buildPagination(
                                ongoingCurrentPage,
                                ongoingMaxPage,
                                (page) {
                                  setState(() => ongoingCurrentPage = page);
                                  auctionOngoingApiRxObj
                                      .getAuctionOngoing(page);
                                },
                              )
                            ],
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Page Selector Builder
  Widget _buildPagination(
      int currentPage, int maxPage, Function(int) onPageSelected) {
    if (maxPage <= 1) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: maxPage,
        itemBuilder: (context, index) {
          final page = index + 1;
          final isSelected = currentPage == page;

          return GestureDetector(
            onTap: () => onPageSelected(page),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$page",
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
