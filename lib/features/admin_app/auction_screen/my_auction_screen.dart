import 'package:ddavila/features/admin_app/auction_screen/model/auction_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/model/auction_running_model.dart';
import 'package:ddavila/features/admin_app/auction_screen/widget/auction_complete.dart';
import 'package:ddavila/features/admin_app/auction_screen/widget/auction_running.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

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
              /// Segmented Tabs
              Container(
                height: 40,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _buildTab("On going", 0),
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

                      if (!snapshot.hasData || snapshot.data?.data == null) {
                        return const Center(
                            child: Text('No profile data available.'));
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
                                  price: value?.price ?? 00,
                                  title: value?.title,
                                  image:
                                  value?.images?.first.toString() ?? "",
                                  endDate: value?.auctionEndAt,
                                  winner: value?.winner,
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

                      if (!snapshot.hasData || snapshot.data?.data == null) {
                        return const Center(
                            child: Text('No profile data available.'));
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

                                return AuctionRunningView(
                                  currentBid: value?.highestBid ?? 00,
                                  title: value?.title,
                                  image:
                                  value?.images?.first.toString() ?? "",
                                  timeLeft: value?.auctionEndAt,
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
                              auctionOngoingApiRxObj.getAuctionOngoing(page);
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
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
