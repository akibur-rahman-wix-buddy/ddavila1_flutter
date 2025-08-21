// ignore_for_file: unused_element
import 'package:ddavila/assets_helper/app_colors.dart';
import 'package:ddavila/assets_helper/app_icons.dart';
import 'package:ddavila/assets_helper/text_font_style.dart';
import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_button.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
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
            child: Column(
              children: [
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
                                '12,960',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'Atal Auction ',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
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
                                '12,960',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'Atal Auction ',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
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
                                '12,960',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'Total Earning',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
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
                                '12,960',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
                                    .copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'Item Sold',
                                style: TextFontStyle.textLine7w400cFFFFFFDmSans
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
                          "Top Auction Overview",
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Apr 30 - May 1",
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
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
                                  spots: [
                                    FlSpot(0, 1),
                                    FlSpot(1, 1.3),
                                    FlSpot(2, 1.2),
                                    FlSpot(3, 1.8),
                                    FlSpot(4, 3),
                                    FlSpot(5, 2.5),
                                    FlSpot(6, 2.8),
                                    FlSpot(7, 2.2),
                                  ],
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
                                        Colors.white
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
                        Text(
                          "Top Bidder",
                          style:
                              TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _bidderItem("AMZN", "Amazon Inc", "16,890"),
                        const SizedBox(height: 12),
                        _bidderItem("AMZN", "Amazon Inc", "16,890"),
                        const SizedBox(height: 12),
                        _bidderItem("AMZN", "Amazon Inc", "16,890"),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpace(
                  10,
                ),
              ],
            ),
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
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              name,
              style: TextFontStyle.textLine7w400cFFFFFFDmSans.copyWith(
                color: AppColor.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),

        // Middle: Sparkline chart
        SizedBox(
          width: 80,
          height: 40,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(1, 1.2),
                    FlSpot(2, 1.1),
                    FlSpot(3, 1.3),
                    FlSpot(4, 1.8),
                    FlSpot(5, 1.5),
                    FlSpot(6, 1.7),
                    FlSpot(7, 1.1),
                  ],
                  isCurved: true,
                  color: Colors.green,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.green.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
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
