import 'package:ddavila/features/user_app/recent_won_bits/model/recent_won_data_model.dart' hide State;
import 'package:ddavila/features/user_app/recent_won_bits/widget/resent_won_card.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentWonScreen extends StatefulWidget {
  const RecentWonScreen({super.key});

  @override
  State<RecentWonScreen> createState() => _RecentWonScreenState();
}

class _RecentWonScreenState extends State<RecentWonScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool isLoadingMore = false;
  List<RecentWonDatum> allOrders = [];
  bool hasMorePages = true;

  @override
  void initState() {
    super.initState();
    getRecentWonProductRx.getRecentWonProductData(pageNumber: currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9 &&
          !isLoadingMore &&
          hasMorePages) {
        loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void loadMoreData() async {
    if (isLoadingMore || !hasMorePages) return;
    setState(() {
      isLoadingMore = true;
    });
    final data = await getRecentWonProductRx.getRecentWonProductData(pageNumber: currentPage + 1);
    if (data?.data?.data != null && data!.data!.data!.isNotEmpty) {
      setState(() {
        currentPage++;
        allOrders.addAll(data.data!.data!);
        hasMorePages = data.data!.nextPageUrl != null && data.data!.currentPage! < data.data!.lastPage!;
        isLoadingMore = false;
      });
    } else {
      setState(() {
        isLoadingMore = false;
        hasMorePages = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Recent Won Items'),
      //   centerTitle: true,
      //   backgroundColor: Colors.blueAccent,
      // ),
      body: Column(
        children: [
          StreamBuilder<RecentWonDataModel>(
            stream: getRecentWonProductRx.dataFetcher,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  allOrders.isEmpty) {
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
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data?.data == null || snapshot.data!.data!.data!.isEmpty) {
                return const Center(child: Text("No data found."));
              }

              if (snapshot.data!.data!.data != null) {
                final newOrders = snapshot.data!.data!.data!.where((newOrder) =>
                !allOrders.any((existingOrder) => existingOrder.id == newOrder.id)).toList();
                if (newOrders.isNotEmpty) {
                  allOrders.addAll(newOrders);
                }
                hasMorePages = snapshot.data!.data!.nextPageUrl != null &&
                    snapshot.data!.data!.currentPage! < snapshot.data!.data!.lastPage!;
              }

              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: allOrders.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= allOrders.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final order = allOrders[index];
                    final product = order.products?.isNotEmpty == true ? order.products!.first : null;

                    return RecentOwnCard(
                      title: product?.title ?? 'No Title',
                      image: product?.images?.isNotEmpty == true ? product!.images!.first : '',
                      currentBid: product?.bid?.toString() ?? '0',
                      timeLeft: product?.auctionEndAt?.toIso8601String() ?? '',
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}