

import 'package:ddavila/features/admin_app/bit_history/widget/bid_history_table.dart';
import 'package:ddavila/features/auth_screen/complete_account_info/complete_account_info_screen.dart';
import 'package:ddavila/features/auth_screen/presentation/card_add_in_stripe.dart';
import 'package:ddavila/helpers/all_routes.dart';
import 'package:ddavila/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:rxdart/subjects.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ddavila/features/admin_app/bit_history/data/get_Bit_history_data/buying_order_rx.dart';
import 'package:ddavila/features/admin_app/bit_history/model/bit_history_data_model.dart';
import 'package:ddavila/networks/endpoints.dart';

class BidHistoryScreen extends StatefulWidget {
  const BidHistoryScreen({Key? key}) : super(key: key);

  @override
  _BidHistoryScreenState createState() => _BidHistoryScreenState();
}

class _BidHistoryScreenState extends State<BidHistoryScreen> {
  late GetBidHistoryRX _bidHistoryRX;
  final BehaviorSubject<BidHistoryDataModel> _dataFetcher = BehaviorSubject<BidHistoryDataModel>();
  final TextEditingController _searchController = TextEditingController();
  List<BidHistoryData> _filteredBidHistoryData = [];
  List<BidHistoryData> _originalBidHistoryData = [];
  bool _isInitialDataLoaded = false;
  BidHistoryData? _selectedRow; // Selected row for showing details

  @override
  void initState() {
    super.initState();

    // Initialize RX
    _bidHistoryRX = GetBidHistoryRX(
      empty: BidHistoryDataModel(success: false, message: "", data: [], code: 0),
      dataFetcher: _dataFetcher,
    );


    String formatDate(String isoDate) {
      try {
        DateTime date = DateTime.parse(isoDate);
        return "${date.month}/${date.day}/${date.year}";
      } catch (e) {
        return "Invalid date";
      }
    }


    // Fetch data initially
    _fetchData();

    // Listen to search text changes
    _searchController.addListener(_filterData);
  }

  Future<void> _fetchData() async {
    await _bidHistoryRX.getBidHistoryRX();
  }

  void _filterData() {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _filteredBidHistoryData = List.from(_originalBidHistoryData);
        _selectedRow = null; // Clear selection when filtering
      });
    } else {
      setState(() {
        _filteredBidHistoryData = _originalBidHistoryData.where((bid) {
          return (bid.product?.title?.toLowerCase().contains(query) ?? false) ||
              (bid.amount?.toString().contains(query) ?? false) ||
              ((bid.isWinner == 1 ? 'Yes' : 'No').toLowerCase().contains(query)) ||
              (bid.createdAt?.toLowerCase().contains(query) ?? false);
        }).toList();
        _selectedRow = null; // Clear selection when filtering
      });
    }
  }

  void _updateData(List<BidHistoryData> newData) {
    // Use post-frame callback to update state after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _originalBidHistoryData = newData;
          _isInitialDataLoaded = true;
        });
        _filterData(); // Apply any existing search filter
      }
    });
  }

  void _showRowDetails(BidHistoryData data) {
    setState(() {
      _selectedRow = data;
    });

    NavigationService.navigateToWithArgs(
      Routes.productsBidScreen,
      {"slag": data.product?.slug, "productId": data.productId},
    );

  print(">>>>>>>>>>>>>>> here is the product type ${data.product?.slug}");
  print(">>>>>>>>>>>>>>> here is the not sale, and this is id product id ${data.product?.id}");
    print("Selected row ID: ${data.productId}");
    print("Selected row ID: ${data.product?.slug}");
  }

  @override
  void dispose() {
    _dataFetcher.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Auction History'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: StreamBuilder<BidHistoryDataModel>(
        stream: _dataFetcher.stream,
        initialData: BidHistoryDataModel(success: false, message: "", data: [], code: 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_isInitialDataLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load bid history. Please try again.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final data = snapshot.data!;
          final bidHistoryData = data.data ?? [];
          final errorMessage = data.message ?? '';

          // Update data after build is complete
          if (!_isInitialDataLoaded || _originalBidHistoryData != bidHistoryData) {
            _updateData(bidHistoryData);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Review all your past bids in one place.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stay informed about your bidding activity and outcomes.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(height: 1, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          '${_filteredBidHistoryData.length} Auctions',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by product name, amount, status, or date...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1),

              // Search Bar

              const SizedBox(height: 8),

              // // Selected Row Details (if any)
              // if (_selectedRow != null)
              //   Container(
              //     padding: EdgeInsets.all(16),
              //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     decoration: BoxDecoration(
              //       color: Colors.blue[50],
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: Colors.blue[100]!),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Selected Bid Details - ID: ${_selectedRow!.id}',
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.blue[800],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),

              // Data Grid Section
              Expanded(
                child: errorMessage.isNotEmpty && _filteredBidHistoryData.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
                    : _filteredBidHistoryData.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.gavel,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchController.text.isEmpty
                            ? 'No bid history available'
                            : 'No results found for "${_searchController.text}"',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _searchController.text.isEmpty
                            ? 'Start bidding on products to see your history here'
                            : 'Try different search terms',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
                    : Container(
                  color: Colors.white,
                  child: SfDataGrid(
                    source: BidHistoryDataSource(
                      bidHistoryData: _filteredBidHistoryData,
                      context: context,
                      refresh: _fetchData,
                      onRowTap: _showRowDetails, // Pass the callback
                    ),
                    columnWidthMode: ColumnWidthMode.fill,
                    gridLinesVisibility: GridLinesVisibility.none,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    selectionMode: SelectionMode.single,
                    onCellTap: (details) {
                      if (details.rowColumnIndex.rowIndex > 0) {
                        final rowIndex = details.rowColumnIndex.rowIndex - 1;
                        if (rowIndex < _filteredBidHistoryData.length) {
                          // Print only the ID
                          print("Clicked row ID: ${_filteredBidHistoryData[rowIndex].id}");
                          _showRowDetails(_filteredBidHistoryData[rowIndex]);
                        }
                      }
                    },
                    columns: <GridColumn>[
                      GridColumn(
                        columnName: 'ProductName',
                        width: 200, // Set to 200 as requested
                        label: Container(
                          padding: EdgeInsets.all(12.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Product Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Amount',
                        width: 120,
                        label: Container(
                          padding: EdgeInsets.all(12.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Bid Amount',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'IsWinner',
                        width: 100,
                        label: Container(
                          padding: EdgeInsets.all(12.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Win Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'CreatedAt',
                        width: 120,
                        label: Container(
                          padding: EdgeInsets.all(12.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ProductImage',
                        width: 80,
                        label: Container(
                          padding: EdgeInsets.all(12.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}