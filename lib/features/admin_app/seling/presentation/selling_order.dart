// ignore_for_file: undefined_hidden_name

import 'package:ddavila/common_widgets/custom_appbar.dart';
import 'package:ddavila/common_widgets/custom_textfiled.dart';
import 'package:ddavila/features/admin_app/seling/model/selling_order_data_model.dart' hide State;
import 'package:ddavila/features/admin_app/seling/widget/selling_table.dart';
import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';

class SellingOrder extends StatefulWidget {
  const SellingOrder({super.key});

  @override
  State<SellingOrder> createState() => _SellingOrderState();
}

class _SellingOrderState extends State<SellingOrder> {
  final TextEditingController _searchController = TextEditingController();
  List<SellerOrderDatum> _filteredData = [];
  List<SellerOrderDatum> _originalData = [];

  @override
  void initState() {
    super.initState();
    getSellingOrderRX.getSellingOrderRX();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterData(_searchController.text);
    });
  }

  void _filterData(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredData = List.from(_originalData);
      } else {
        _filteredData = _originalData.where((order) {
          return order.orderNumber?.toLowerCase().contains(query.toLowerCase()) ==
              true ||
              order.status
                  ?.toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ==
                  true ||
              order.trackingNumber?.toLowerCase().contains(query.toLowerCase()) ==
                  true ||
              order.totalAmount?.toLowerCase().contains(query.toLowerCase()) ==
                  true ||
              _containsProductName(order, query.toLowerCase()) ||
              _containsCustomerName(order, query.toLowerCase());
        }).toList();
      }
    });
  }

  bool _containsProductName(SellerOrderDatum order, String query) {
    if (order.orderItems == null) return false;
    return order.orderItems?.any(
            (item) => item.product?.title?.toLowerCase().contains(query) == true) ??
        false;
  }

  bool _containsCustomerName(SellerOrderDatum order, String query) {
    return order.user?.name?.toString().toLowerCase().contains(query) == true;
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Selling Order', isCenterTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: StreamBuilder<SellingOrderDataModel>(
          stream: getSellingOrderRX.dataFetcher,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: CircularProgressIndicator()),
                  UIHelper.verticalSpace(10),
                  const Text("Loading...", style: TextStyle(color: Colors.red)),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            } else if (!snapshot.hasData || snapshot.data?.data?.data == null) {
              return const Center(child: Text("No data found."));
            } else {
              _originalData = snapshot.data?.data?.data ?? [];
              if (_filteredData.isEmpty && _searchController.text.isEmpty) {
                _filteredData = List.from(_originalData);
              }

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_filteredData.length} Selling order",
                        style: const TextStyle(
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
                        prefixIcon: const Icon(Icons.search_sharp, size: 24),
                        controller: _searchController,
                        onChanged: _filterData,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12),
                  Expanded(
                    child: SellingTable(
                      data: _filteredData,
                      onDataUpdated: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          getSellingOrderRX.getSellingOrderRX();
                        });
                      },
                    ),
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