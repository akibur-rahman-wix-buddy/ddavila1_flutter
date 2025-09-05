// import 'dart:convert';
//
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../model/buying_order_data_model.dart' hide State;
//
// class BuyingTable extends StatefulWidget {
//   final List<BuyingOrderDatum> data;
//   final VoidCallback onDataUpdated;
//
//   const BuyingTable({
//     super.key,
//     required this.data,
//     required this.onDataUpdated,
//   });
//
//   @override
//   State<BuyingTable> createState() => _BuyingTableState();
// }
//
// class _BuyingTableState extends State<BuyingTable> {
//   late DataGridController _dataGridController;
//   Map<int, bool> _loadingStates = {};
//   List<BuyingOrderDatum> _currentData = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _dataGridController = DataGridController();
//     _currentData = widget.data;
//
//     for (var order in _currentData) {
//       if (order.id != null) {
//         _loadingStates[order.id!] = false;
//       }
//     }
//   }
//
//   @override
//   void didUpdateWidget(BuyingTable oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.data != oldWidget.data) {
//       setState(() {
//         _currentData = widget.data;
//         _loadingStates.clear();
//         for (var order in _currentData) {
//           if (order.id != null) {
//             _loadingStates[order.id!] = false;
//           }
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//           color: Colors.grey[100],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(bottom: 16.0),
//               child: Text(
//                 'Orders',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 3,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: SfDataGrid(
//                   source: OrderDataSource(
//                     _currentData,
//                     loadingStates: _loadingStates,
//                     onButtonPressed: _handleButtonPressed,
//                     refresh: () => setState(() {}),
//                   ),
//                   controller: _dataGridController,
//                   columnWidthMode: ColumnWidthMode.fill,
//                   gridLinesVisibility: GridLinesVisibility.horizontal,
//                   headerGridLinesVisibility: GridLinesVisibility.horizontal,
//                   columns: [
//                     GridColumn(
//                       columnName: 'OrderNumber',
//                       width: 120,
//                       label: _buildHeader('Order Number', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'ProductName',
//                       width: 150,
//                       label: _buildHeader('Product Name', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'TotalAmount',
//                       width: 120,
//                       label: _buildHeader('Total Amount', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'Status',
//                       width: 120,
//                       label: _buildHeader('Status', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'shippingAddress',
//                       width: 120,
//                       label: _buildHeader('Shipping Address', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'Tracking',
//                       width: 120,
//                       label: _buildHeader('Tracking', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'OrderDate',
//                       width: 120,
//                       label: _buildHeader('Order Date', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'Action',
//                       width: 150,
//                       label: _buildHeader('Action', Alignment.center),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handleButtonPressed(int id, String currentStatus) async {
//     print('Button pressed for order ID: $id with status: $currentStatus');
//
//     final orderIndex = _currentData.indexWhere((order) => order.id == id);
//     if (orderIndex == -1) return;
//
//     final order = _currentData[orderIndex];
//
//     final bool confirm = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Action'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                   'Are you sure you want to ${currentStatus.toLowerCase() == 'shipping' ? 'accept' : 'complete'} this order?'),
//               SizedBox(height: 16),
//               Text('Order #${order.orderNumber ?? 'N/A'}',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text(
//                   'Product: ${order.orderItems?.first.product?.title ?? 'Unknown'}'),
//               SizedBox(height: 8),
//               Text('Total: \$${order.totalAmount?.toString() ?? '0.00'}'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (confirm != true) {
//       return;
//     }
//
//     setState(() {
//       _loadingStates[id] = true;
//     });
//
//     bool success =
//     await buyingOrderConfirmRx.buyingOrderConfirmInfo(productId: id);
//
//     if (success) {
//       widget.onDataUpdated();
//       setState(() {
//         int index = _currentData.indexWhere((order) => order.id == id);
//         if (index != -1) {
//           if (currentStatus.toLowerCase() == 'shipping') {
//             _currentData[index].status = DatumStatus.confirmed;
//           } else if (currentStatus.toLowerCase() == 'confirmed') {
//             _currentData[index].status = DatumStatus.completed;
//           }
//         }
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//               'Order #${order.orderNumber} has been ${currentStatus.toLowerCase() == 'shipping' ? 'accepted' : 'completed'} successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to update order #${order.orderNumber}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//
//     setState(() {
//       _loadingStates[id] = false;
//     });
//   }
//
//   Widget _buildHeader(String text, Alignment alignment) {
//     return Container(
//       alignment: alignment,
//       padding: EdgeInsets.all(12.0),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//           color: Colors.blueGrey[800],
//         ),
//       ),
//     );
//   }
// }
//
// class OrderDataSource extends DataGridSource {
//   List<BuyingOrderDatum> orderData;
//   final Map<int, bool> loadingStates;
//   final Function(int, String) onButtonPressed;
//   final VoidCallback refresh;
//
//   OrderDataSource(
//       this.orderData, {
//         required this.loadingStates,
//         required this.onButtonPressed,
//         required this.refresh,
//       });
//
//   @override
//   List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
//     String productNames = data.orderItems
//         ?.map((item) => item.product?.title ?? 'Unknown Product')
//         .join(', ') ??
//         'No Products';
//     String orderDate = data.orderedAt?.toString().split(' ')[0] ?? 'N/A';
//     String tracking = data.trackingNumber ?? 'No tracking';
//
//
//
//     print(">>>>>>>>>>>>>>>>>>>>> ${data.user?.address.toString()}");
//     print(">>>>>>>>>>>>>>>>>>>>> ${data.user?.city.toString()}");
//     print(">>>>>>>>>>>>>>>>>>>>> ${data.user?.state.toString()}");
//     print(">>>>>>>>>>>>>>>>>>>>> ${data.user?.country.toString()}");
//
//
//     // Format shipping address
//     String shippingAddress = 'No Address';
//     if (data.user != null) {
//       final address = data.user!;
//       List<String> addressParts = [];
//
//       if (address.address != null && address.address.toString().isNotEmpty) {
//         addressParts.add(address.address.toString());
//       }
//       if (address.city != null && address.city.toString().isNotEmpty) {
//         addressParts.add(address.city.toString());
//       }
//       if (address.state != null && address.state.toString().isNotEmpty) {
//         addressParts.add(address.state.toString());
//       }
//       if (address.country != null && address.country.toString().isNotEmpty) {
//         addressParts.add(address.country!);
//       }
//       if (addressParts.isNotEmpty) {
//         shippingAddress = addressParts.join(', ');
//       }
//     }
//
//     String status = data.status?.toString().split('.').last ?? 'Pending';
//     status = status[0].toUpperCase() + status.substring(1).toLowerCase();
//
//     String buttonText;
//     bool isButtonActive;
//
//     if (status.toLowerCase() == 'completed') {
//       buttonText = 'Completed';
//       isButtonActive = false;
//     } else if (status.toLowerCase() == 'shipping') {
//       buttonText = 'Accept';
//       isButtonActive = true;
//     } else if (status.toLowerCase() == 'confirmed') {
//       buttonText = 'Complete';
//       isButtonActive = false; // Allow completing confirmed orders
//     } else {
//       buttonText = 'Complete Order';
//       isButtonActive = false;
//     }
//
//     return DataGridRow(cells: [
//       DataGridCell<String>(
//           columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
//       DataGridCell<String>(columnName: 'ProductName', value: productNames),
//       DataGridCell<String>(
//           columnName: 'TotalAmount',
//           value: '\$${data.totalAmount?.toString() ?? '0.00'}'),
//       DataGridCell<String>(columnName: 'Status', value: status),
//       DataGridCell<String>(columnName: 'shippingAddress', value: shippingAddress),
//       DataGridCell<String>(columnName: 'Tracking', value: tracking),
//       DataGridCell<String>(columnName: 'OrderDate', value: orderDate),
//       DataGridCell<Map<String, dynamic>>(
//           columnName: 'Action',
//           value: {
//             'text': buttonText,
//             'isActive': isButtonActive,
//             'id': data.id ?? 0,
//             'status': status,
//           }),
//     ]);
//   }).toList();
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     final int rowIndex = effectiveRows.indexOf(row);
//
//     return DataGridRowAdapter(
//       color: rowIndex % 2 == 0 ? Colors.grey[50] : Colors.white,
//       cells: row.getCells().map<Widget>((dataCell) {
//         if (dataCell.columnName == 'ProductName') {
//           return Container(
//             alignment: Alignment.center, // Left-align for better readability
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value.toString(),
//               maxLines: 1, // Restrict to one line
//               overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.black87,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'OrderNumber' ||
//             dataCell.columnName == 'OrderDate') {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value.toString(),
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.black87,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'TotalAmount') {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value.toString(),
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//                 color: Colors.blue[800],
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Status') {
//           Color statusColor;
//           switch (dataCell.value.toString().toLowerCase()) {
//             case 'confirmed':
//               statusColor = Colors.green;
//               break;
//             case 'completed':
//               statusColor = Colors.grey;
//               break;
//             case 'shipping':
//               statusColor = Colors.blue;
//               break;
//             case 'pending':
//               statusColor = Colors.orange;
//               break;
//             default:
//               statusColor = Colors.grey;
//           }
//
//           return Container(
//             margin: EdgeInsets.all(10),
//             alignment: Alignment.center,
//             padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//             decoration: BoxDecoration(
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               dataCell.value.toString(),
//               style: TextStyle(
//                 color: statusColor,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//           );
//         }  else if (dataCell.columnName == 'shippingAddress') {
//           return Container(
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value?.toString() ?? 'No Address',
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: Colors.black87,
//               ),
//             ),
//           );
//         }else if (dataCell.columnName == 'Tracking') {
//           final trackingNumber = dataCell.value.toString();
//           final hasTracking = trackingNumber != 'No tracking';
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: hasTracking
//                 ? ElevatedButton(
//               onPressed: () {
//                 print("hello world");
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               child: Text(
//                 'View Tracking',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.white,
//                 ),
//               ),
//             )
//                 : Text(
//               'No tracking',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Action') {
//           final actionData = dataCell.value as Map<String, dynamic>?;
//           final buttonText = actionData?['text'] ?? 'Complete Order';
//           final isButtonActive = actionData?['isActive'] ?? true;
//           final id = actionData?['id'] ?? 0;
//           final status = actionData?['status'] ?? 'Pending';
//           final isLoading = loadingStates[id] ?? false;
//
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(4.0),
//             child: isLoading
//                 ? CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//               strokeWidth: 2,
//             )
//                 : ElevatedButton(
//               onPressed: isButtonActive && !isLoading
//                   ? () async {
//                 await onButtonPressed(id, status);
//                 refresh();
//               }
//                   : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                 isButtonActive && !isLoading ? Colors.blue : Colors.grey,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               child: Text(
//                 buttonText,
//                 style: TextStyle(fontSize: 12, color: Colors.white),
//               ),
//             ),
//           );
//         }
//         return Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.all(8.0),
//           child: Text(dataCell.value.toString()),
//         );
//       }).toList(),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//














import 'dart:convert';
import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../model/buying_order_data_model.dart' hide State;

class BuyingTable extends StatefulWidget {
  final List<BuyingOrderDatum> data;
  final VoidCallback onDataUpdated;

  const BuyingTable({
    super.key,
    required this.data,
    required this.onDataUpdated,
  });

  @override
  State<BuyingTable> createState() => _BuyingTableState();
}

class _BuyingTableState extends State<BuyingTable> {
  late DataGridController _dataGridController;
  Map<int, bool> _loadingStates = {};
  List<BuyingOrderDatum> _currentData = [];

  @override
  void initState() {
    super.initState();
    _dataGridController = DataGridController();
    _currentData = widget.data;

    for (var order in _currentData) {
      if (order.id != null) {
        _loadingStates[order.id!] = false;
      }
    }
  }

  @override
  void didUpdateWidget(BuyingTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      setState(() {
        _currentData = widget.data;
        _loadingStates.clear();
        for (var order in _currentData) {
          if (order.id != null) {
            _loadingStates[order.id!] = false;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext contextOne) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Orders',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SfDataGrid(
                  source: OrderDataSource(
                    context: contextOne,
                    orderData: _currentData,
                    loadingStates: _loadingStates,
                    onButtonPressed: _handleButtonPressed,
                    refresh: () => setState(() {}),
                  ),
                  controller: _dataGridController,
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  columns: [
                    GridColumn(
                      columnName: 'OrderNumber',
                      width: 150,
                      label: _buildHeader('Order Number', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'ProductName',
                      width: 150,
                      label: _buildHeader('Product Name', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'TotalAmount',
                      width: 120,
                      label: _buildHeader('Total Amount', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'Status',
                      width: 120,
                      label: _buildHeader('Status', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'shippingAddress',
                      width: 120,
                      label: _buildHeader('Shipping Address', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'Tracking',
                      width: 120,
                      label: _buildHeader('Tracking', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'OrderDate',
                      width: 120,
                      label: _buildHeader('Order Date', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'Action',
                      width: 150,
                      label: _buildHeader('Action', Alignment.center),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleButtonPressed(int id, String currentStatus) async {
    print('Button pressed for order ID: $id with status: $currentStatus');

    final orderIndex = _currentData.indexWhere((order) => order.id == id);
    if (orderIndex == -1) return;

    final order = _currentData[orderIndex];

    final bool? confirm = await showDialog<bool>(
      context: context, // Use the State class's context
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirm Action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Are you sure you want to ${currentStatus.toLowerCase() == 'shipping' ? 'accept' : 'complete'} this order?'),
              SizedBox(height: 16),
              Text('Order #${order.orderNumber ?? 'N/A'}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                  'Product: ${order.orderItems?.first.product?.title ?? 'Unknown'}'),
              SizedBox(height: 8),
              Text('Total: \$${order.totalAmount?.toString() ?? '0.00'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    setState(() {
      _loadingStates[id] = true;
    });

    bool success =
    await buyingOrderConfirmRx.buyingOrderConfirmInfo(productId: id);

    if (success) {
      widget.onDataUpdated();
      setState(() {
        int index = _currentData.indexWhere((order) => order.id == id);
        if (index != -1) {
          if (currentStatus.toLowerCase() == 'shipping') {
            _currentData[index].status = DatumStatus.confirmed;
          } else if (currentStatus.toLowerCase() == 'confirmed') {
            _currentData[index].status = DatumStatus.completed;
          }
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Order #${order.orderNumber} has been ${currentStatus.toLowerCase() == 'shipping' ? 'accepted' : 'completed'} successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update order #${order.orderNumber}'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _loadingStates[id] = false;
    });
  }

  Widget _buildHeader(String text, Alignment alignment) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }
}

class OrderDataSource extends DataGridSource {
  final List<BuyingOrderDatum> orderData;
  final Map<int, bool> loadingStates;
  final Function(int, String) onButtonPressed;
  final VoidCallback refresh;
  final BuildContext context;

  OrderDataSource({
    required this.orderData,
    required this.loadingStates,
    required this.onButtonPressed,
    required this.refresh,
    required this.context,
  });

  // void _showTrackingDialog(BuildContext context , BuyingOrderDatum data) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Tracking Information - ${data.orderNumber}'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Table(
  //               border: TableBorder.all(color: Colors.grey.shade300),
  //               columnWidths: {
  //                 0: FlexColumnWidth(2),
  //                 1: FlexColumnWidth(3),
  //               },
  //               children: [
  //                 TableRow(children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text('Shipping Company',
  //                         style: TextStyle(fontWeight: FontWeight.w500)),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(data.companyName.toString()),
  //                   ),
  //                 ]),
  //                 TableRow(children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text('Tracking Number',
  //                         style: TextStyle(fontWeight: FontWeight.w500)),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(data.trackingNumber.toString()),
  //                   ),
  //                 ]),
  //               ],
  //             ),
  //             const SizedBox(height: 16),
  //             Row(
  //               children: [
  //                 Text('Order Status: '),
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                   decoration: BoxDecoration(
  //                     color: Colors.blue.shade50,
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                   child: Text(
  //                     data.status.toString(),
  //                     style: TextStyle(color: Colors.blue),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 8),
  //             Text('Total Amount: \$355.98'),
  //             const SizedBox(height: 8),
  //             Text('Order Date: 04/09/2025, 14:38:42'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text('Close'),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
    String productNames = data.orderItems
        ?.map((item) => item.product?.title ?? 'Unknown Product')
        .join(', ') ??
        'No Products';
    String orderDate = data.orderedAt?.toString().split(' ')[0] ?? 'N/A';
    String tracking = data.trackingNumber ?? 'No tracking';

    String shippingAddress = 'No Address';
    if (data.user != null) {
      final address = data.user!;
      List<String> addressParts = [];

      if (address.address?.isNotEmpty == true) addressParts.add(address.address!);
      if (address.city?.isNotEmpty == true) addressParts.add(address.city!);
      if (address.state?.isNotEmpty == true) addressParts.add(address.state!);
      if (address.country?.isNotEmpty == true) addressParts.add(address.country!);

      if (addressParts.isNotEmpty) {
        shippingAddress = addressParts.join(', ');
      }
    }

    String status = data.status?.toString().split('.').last ?? 'Pending';
    status = status[0].toUpperCase() + status.substring(1).toLowerCase();

    String buttonText;
    bool isButtonActive;

    if (status.toLowerCase() == 'completed') {
      buttonText = 'Completed';
      isButtonActive = false;
    } else if (status.toLowerCase() == 'shipping') {
      buttonText = 'Accept';
      isButtonActive = true;
    } else if (status.toLowerCase() == 'confirmed') {
      buttonText = 'Complete';
      isButtonActive = false;
    } else {
      buttonText = 'Complete Order';
      isButtonActive = false;
    }

    return DataGridRow(cells: [
      DataGridCell<String>(columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
      DataGridCell<String>(columnName: 'ProductName', value: productNames),
      DataGridCell<String>(
          columnName: 'TotalAmount', value: '\$${data.totalAmount?.toString() ?? '0.00'}'),
      DataGridCell<String>(columnName: 'Status', value: status),
      DataGridCell<String>(columnName: 'shippingAddress', value: shippingAddress),
      DataGridCell<String>(columnName: 'Tracking', value: tracking),
      DataGridCell<String>(columnName: 'OrderDate', value: orderDate),
      DataGridCell<Map<String, dynamic>>(
          columnName: 'Action',
          value: {
            'text': buttonText,
            'isActive': isButtonActive,
            'id': data.id ?? 0,
            'status': status,
          }),
    ]);
  }).toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = effectiveRows.indexOf(row);

    return DataGridRowAdapter(
      color: rowIndex % 2 == 0 ? Colors.grey[50] : Colors.white,
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'ProductName') {
          return _cell(text: dataCell.value.toString(), alignment: Alignment.centerLeft);
        } else if (dataCell.columnName == 'OrderNumber' ||
            dataCell.columnName == 'OrderDate') {
          return _cell(text: dataCell.value.toString(), alignment: Alignment.center);
        } else if (dataCell.columnName == 'TotalAmount') {
          return _cell(
              text: dataCell.value.toString(),
              alignment: Alignment.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]));
        } else if (dataCell.columnName == 'Status') {
          Color statusColor;
          switch (dataCell.value.toString().toLowerCase()) {
            case 'confirmed':
              statusColor = Colors.green;
              break;
            case 'completed':
              statusColor = Colors.grey;
              break;
            case 'shipping':
              statusColor = Colors.blue;
              break;
            case 'pending':
              statusColor = Colors.orange;
              break;
            default:
              statusColor = Colors.grey;
          }

          return Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          );
        } else if (dataCell.columnName == 'shippingAddress') {
          return _cell(
            text: dataCell.value?.toString() ?? 'No Address',
            alignment: Alignment.centerLeft,
            maxLines: 2,
          );
        } else if (dataCell.columnName == 'Tracking') {
          final trackingNumber = dataCell.value.toString();
          final hasTracking = trackingNumber != 'No tracking';
          final data = orderData[effectiveRows.indexOf(row)];
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: hasTracking
                ? ElevatedButton(
              onPressed: () {
                _showTrackingDialog(context, data);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: Text(
                'View Tracking',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
                : Text(
              'No tracking',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        } else if (dataCell.columnName == 'Action') {
          final actionData = dataCell.value as Map<String, dynamic>?;
          final buttonText = actionData?['text'] ?? 'Complete Order';
          final isButtonActive = actionData?['isActive'] ?? true;
          final id = actionData?['id'] ?? 0;
          final status = actionData?['status'] ?? 'Pending';
          final isLoading = loadingStates[id] ?? false;

          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4.0),
            child: isLoading
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 2,
            )
                : ElevatedButton(
              onPressed: isButtonActive && !isLoading
                  ? () async {
                await onButtonPressed(id, status);
                refresh();
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonActive && !isLoading
                    ? Colors.blue
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          );
        }

        return _cell(text: dataCell.value.toString());
      }).toList(),
    );
  }

  Widget _cell({
    required String text,
    Alignment alignment = Alignment.center,
    TextStyle? style,
    int maxLines = 1,
  }) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: style ??
            TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
      ),
    );
  }
}


void _showTrackingDialog(BuildContext context, BuyingOrderDatum data) {


  String formatDate(String isoDate) {
    try {
      DateTime date = DateTime.parse(isoDate);
      return "${date.month}/${date.day}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Tracking Information - ${data.orderNumber}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Shipping Company',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data.companyName.toString()),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Tracking Number',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data.trackingNumber.toString()),
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('Order Status: '),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.status?.name.toString()??"",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Total Amount: \$${data.totalAmount?.toString() ?? '0.00'}'), // Updated to use data
            const SizedBox(height: 8),
            Text('Order Date: ${formatDate(data.orderedAt?.toString() ?? 'N/A')}'), // Updated to use data
          ],
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
