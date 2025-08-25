
// ignore_for_file: unused_shown_name

import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/buying_order_data_model.dart' show BuyingOrderDataModel, OrderItem, BuyingOrderDatum;
import '../widget/buying_table.dart';

class BuyingOrderScreen extends StatefulWidget {
  const BuyingOrderScreen({super.key});

  @override
  State<BuyingOrderScreen> createState() => _BuyingOrderScreenState();
}


class _BuyingOrderScreenState extends State<BuyingOrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<BuyingOrderDatum> _filteredData = [];
  List<BuyingOrderDatum> _originalData = [];

  @override
  void initState() {
    getBuyingOrderRX.getBuyingOrderRX();
    super.initState();
  }

  void _filterData(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredData = List.from(_originalData);
      } else {
        _filteredData = _originalData.where((order) {
          return order.orderNumber?.toLowerCase().contains(query.toLowerCase()) == true ||
              order.productType?.toString().toLowerCase().contains(query.toLowerCase()) == true ||
              order.status?.toString().toLowerCase().contains(query.toLowerCase()) == true ||
              order.trackingNumber?.toLowerCase().contains(query.toLowerCase()) == true ||
              order.totalAmount?.toLowerCase().contains(query.toLowerCase()) == true ||
              _containsProductName(order, query.toLowerCase());
        }).toList();
      }
    });
  }

  bool _containsProductName(BuyingOrderDatum order, String query) {
    if (order.orderItems == null) return false;
    return order.orderItems!.any((item) =>
    item.product?.title?.toLowerCase().contains(query) == true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Buying Order', isCenterTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: StreamBuilder<BuyingOrderDataModel>(
          stream: getBuyingOrderRX.dataFetcher,
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
            } else if (!snapshot.hasData || snapshot.data?.data?.data == null) {
              return const Center(child: Text("No data found."));
            } else {
              // Store original data and initialize filtered data
              if (_originalData.isEmpty) {
                _originalData = snapshot.data!.data!.data!;
                _filteredData = List.from(_originalData);
              }

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_filteredData.length} Buying order",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                        ),
                      ),
                      CustomTextField(
                        hintText: "Search",
                        fieldWidth: 200,
                        borderRadius: 30,
                        prefixIcon: Icon(Icons.search_sharp, size: 24),
                        controller: _searchController,
                        onChanged: _filterData,
                      )
                    ],
                  ),
                  UIHelper.verticalSpace(12),
                  BuyingTable(
                    data: _filteredData,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}