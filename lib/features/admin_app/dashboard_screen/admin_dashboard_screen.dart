// ignore_for_file: unused_element, deprecated_member_use
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:ddavila/features/admin_app/widget/admin_table.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../helpers/all_routes.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    adminDashAPIRXObj.getAdminDashRX();
  }

  // মাসগুলোর ক্রম ঠিক রাখতে একটা লিস্ট
  final months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Dashboard'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              16,
            ),
            child: StreamBuilder<AdminDashModel>(
                stream: adminDashAPIRXObj.dataFetcher,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final data = snapshot.data;

                  final dailyData = data?.dailyData as Map<String, dynamic>;

                  // * For Top Auctions
                  final spots =
                      dailyData.entries.toList().asMap().entries.map((entry) {
                    final index = entry.key.toDouble(); // x axis (0,1,2…)
                    final value = (entry.value.value ?? 0).toDouble(); // y axis
                    return FlSpot(index, value);
                  }).toList();

                  // * For Monthly Earnings
                  final earningSpots = months.asMap().entries.map((entry) {
                    final index = entry.key.toDouble(); // X-axis index
                    final month = entry.value;
                    final value =
                        (data?.earning?[month] ?? 0).toDouble(); // Y-axis value
                    return FlSpot(index, value);
                  }).toList();

                  return Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      
                      Text("My Auction History",style: TextFontStyle.headLine22w600cFFFFFFLato.copyWith(color: Colors.black,fontWeight: FontWeight.w700),),
                      UIHelper.verticalSpace(12.h),
                      Text("Review all your past auction in one place. Stay informed about your auction activity and outcomes.",style: TextFontStyle.textLine14w500cFFFFFFLato.copyWith(color: Colors.black87,),),
                      UIHelper.verticalSpace(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 165,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColor.c4275F6,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      height: 46,
                                      width: 46,
                                      AppIcons.bagIcon,
                                    ),
                                    UIHelper.verticalSpace(15),
                                    Text(
                                      data?.auctionsAll?.toString() ?? '0',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      'Total Auction Listings',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 165,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColor.c4275F6,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      height: 46,
                                      width: 46,
                                      AppIcons.bagIcon,
                                    ),
                                    UIHelper.verticalSpace(15),
                                    Text(
                                      data?.auctionsOnGoing?.toString() ?? '0',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      'Total Ongoing Auction',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 165,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColor.c4275F6,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      height: 46,
                                      width: 46,
                                      AppIcons.moneyIcon,
                                    ),
                                    UIHelper.verticalSpace(15),
                                    Text(
                                      data?.totalEarning?.toString() ?? '0',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      'Total Earning',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 165,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColor.c4275F6,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      height: 46,
                                      width: 46,
                                      AppIcons.soldIcon,
                                    ),
                                    UIHelper.verticalSpace(15),
                                    Text(
                                      data?.soldItems?.toString() ?? '0',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      'Item Sold',
                                      style: TextFontStyle
                                          .textLine7w400cFFFFFFDmSans
                                          .copyWith(
                                        color: AppColor.blackColor,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceMedium,
                      CustomButton(
                        text: 'Create an Auction',
                        context: context,
                        minWidth: double.infinity,
                        borderRadius: 10,
                        onTap: () {

                          NavigationService.navigateTo(Routes.createAuctionScreen);

                

                        },
                      ),
                      UIHelper.verticalSpace(
                        10,
                      ),

                      // * auction graph
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Earning Performance",
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Apr 30 - May 1",
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.c666666,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(show: false),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: spots,
                                        isCurved: true,
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.c4275f6,
                                            AppColor.c4275f6
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        barWidth: 2,
                                        isStrokeCapRound: true,
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.c4275f6.withOpacity(0.3),
                                              Colors.white,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        dotData: FlDotData(show: false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      UIHelper.verticalSpace(
                        10,
                      ),

                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Top Bidder",
                                  style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                      .copyWith(
                                    color: AppColor.blackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // এখানে ListView.builder ব্যবহার করছি
                              SizedBox(
                                height: 200,
                                child: (data?.topBidder == null ||
                                        data!.topBidder!.isEmpty)
                                    ? const Center(
                                        child: Text(
                                          "No data available",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: data.topBidder?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final bidder =
                                              data.topBidder?[index];
                                          final user =
                                              bidder?.user?.toJson() ?? {};

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0),
                                            child: _bidderItem(
                                              user['name'] ?? "N/A", // Name
                                              user['country'] ?? "", // Sub text
                                              bidder?.maxBid?.toString() ??
                                                  "0", // Bid amount
                                            ),
                                          );
                                        },
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),

                      UIHelper.verticalSpace(
                        10,
                      ),

                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Earning Performance",
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                height: 200,
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(show: false),
                                    borderData: FlBorderData(show: false),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        // 👈 Y-axis hide
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      rightTitles: AxisTitles(
                                        // optional: right side
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        // optional: top side
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        // 👈 শুধু X-axis (Month) দেখাবে
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            int index = value.toInt();
                                            if (index >= 0 &&
                                                index < months.length) {
                                              return Text(
                                                months[index],
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                      ),
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: earningSpots,
                                        isCurved: true,
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.c4275f6,
                                            AppColor.c4275f6
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        barWidth: 2,
                                        isStrokeCapRound: true,
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.c4275f6.withOpacity(0.3),
                                              Colors.white,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        dotData: FlDotData(show: false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      UIHelper.verticalSpace(16.h),
                      AuctionDataGridData(data: data!.recentAuctions ?? [])
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _bidderItem(String symbol, String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Stock info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symbol,
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                color: AppColor.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              name,
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                color: AppColor.blackColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),

        // Right: Price + arrow
        Row(
          children: [
            Text(
              "\$$price",
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                color: AppColor.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_upward,
              color: Colors.green,
              size: 14,
            ),
          ],
        ),
      ],
    );
  }
}
