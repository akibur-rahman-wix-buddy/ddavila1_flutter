// // ignore_for_file: library_private_types_in_public_api, deprecated_member_use
//
// import 'package:ddavila/features/admin_app/seling/widget/shipping_dialouge_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../model/selling_order_data_model.dart';
//
// class SellingTable extends StatefulWidget {
//   final List<SellerOrderDatum> data;
//   final VoidCallback onDataUpdated;
//
//   const SellingTable({super.key, required this.data, required this.onDataUpdated});
//
//   @override
//   _SellingTableState createState() => _SellingTableState();
// }
//
// class _SellingTableState extends State<SellingTable> {
//   late DataGridController _dataGridController;
//   late OrderDataSource _dataSource;
//
//   @override
//   void initState() {
//     super.initState();
//     _dataGridController = DataGridController();
//     _dataSource = OrderDataSource(widget.data, context, widget.onDataUpdated);
//   }
//
//   @override
//   void didUpdateWidget(covariant SellingTable oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.data != oldWidget.data) {
//       _dataSource = OrderDataSource(widget.data, context, widget.onDataUpdated);
//       setState(() {});
//     }
//   }
//
//   @override
//   void dispose() {
//     _dataGridController.dispose();
//     super.dispose();
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
//                   fontSize: 24.sp,
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
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: SfDataGrid(
//                   source: _dataSource,
//                   controller: _dataGridController,
//                   columnWidthMode: ColumnWidthMode.fill,
//                   gridLinesVisibility: GridLinesVisibility.horizontal,
//                   headerGridLinesVisibility: GridLinesVisibility.horizontal,
//                   columns: [
//                     GridColumn(
//                       columnName: 'OrderNumber',
//                       width: 180,
//                       label: _buildHeader('Order Number', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'ProductName',
//                       width: 180,
//                       label: _buildHeader('Product Name', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'Earnings',
//                       width: 120,
//                       label: _buildHeader('Earnings (After Fees)', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'Breakdown',
//                       width: 180, // Increased width for better display
//                       label: _buildHeader('Breakdown', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'shippingAddress',
//                       width: 120,
//                       label: _buildHeader('Shipping Address', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'Status',
//                       width: 120,
//                       label: _buildHeader('Status', Alignment.center),
//                     ),
//                     GridColumn(
//                       columnName: 'Action',
//                       width: 160,
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
//   Widget _buildHeader(String text, Alignment alignment) {
//     return Container(
//       alignment: alignment,
//       padding: const EdgeInsets.all(12.0),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14.sp,
//           color: Colors.blueGrey[800],
//         ),
//       ),
//     );
//   }
// }
//
//
// class OrderDataSource extends DataGridSource {
//   List<SellerOrderDatum> orderData;
//   final BuildContext context;
//   final VoidCallback onDataUpdated;
//
//   OrderDataSource(this.orderData, this.context, this.onDataUpdated);
//
//   void updateData(List<SellerOrderDatum> newData) {
//     orderData = newData;
//     notifyListeners();
//   }
//
//   @override
//   List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
//     double subtotalValue = 0.0;
//     double earnings = 0.0;
//     String breakdown = 'N/A';
//
//
//
//
//     if (data.orderItems?.isNotEmpty ?? false) {
//       for (var item in data.orderItems!) {
//         if (item.subtotal != null) {
//           subtotalValue += double.tryParse(item.subtotal!) ?? 0.0;
//         }
//       }
//     }
//     String subtotal = subtotalValue.toStringAsFixed(2);
//
//
//
//
//
//     String productNames = 'No Products';
//     if (data.orderItems?.isNotEmpty ?? false) {
//       productNames = data.orderItems!
//           .map((item) => item.product?.title ?? 'Unknown Product')
//           .join(', ');
//     }
//
//
//
//
//
//     // Format shipping address
//     String shippingAddress = 'No Address';
//     if (data.user != null) {
//       final address = data.user!;
//       List<String> addressParts = [];
//
//       if (address.address != null && address.address!.isNotEmpty) {
//         addressParts.add(address.address!);
//       }
//       if (address.city != null && address.city!.isNotEmpty) {
//         addressParts.add(address.city!);
//       }
//       if (address.state != null && address.state!.isNotEmpty) {
//         addressParts.add(address.state!);
//       }
//       if (address.country != null && address.country!.isNotEmpty) {
//         addressParts.add(address.country!);
//       }
//
//       if (addressParts.isNotEmpty) {
//         shippingAddress = addressParts.join(', ');
//       }
//     }
//
//     if (data.orderItems?.isNotEmpty ?? false) {
//       double productFee = 0.0;
//       for (var item in data.orderItems!) {
//         if (item.subtotal != null) {
//           productFee += double.tryParse(item.subtotal!) ?? 0.0;
//         }
//       }
//
//       double shippingAmount = double.tryParse(data.shippingAmount?.toString() ?? '0') ?? 0.0;
//       double platformFee = double.tryParse(data.platformFee?.toString() ?? '0') ?? 0.0;
//
//       breakdown = 'Product fee: \$${productFee.toStringAsFixed(2)}\n'
//           'Shipping: \$${shippingAmount.toStringAsFixed(2)}\n'
//           'Platform Fee: -\$${platformFee.abs().toStringAsFixed(2)}';
//     }
//
//
//
//
//     String status =
//         data.status?.toString().split('.').last.toLowerCase() ?? 'unknown';
//     print(">>>>>>>> Status from SellerOrderDatum: $status");
//
//     return DataGridRow(cells: [
//       DataGridCell<String>(
//           columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
//       DataGridCell<String>(columnName: 'ProductName', value: productNames),
//       DataGridCell<String>(columnName: 'Earnings', value: '\$${earnings.toStringAsFixed(2)}'),
//       DataGridCell<String>(columnName: 'Breakdown', value: breakdown),
//       DataGridCell<String>(columnName: 'shippingAddress', value: shippingAddress),
//       DataGridCell<String>(columnName: 'Status', value: status),
//       DataGridCell<Map<String, dynamic>>(
//         columnName: 'Action',
//         value: {
//           'text': 'Add Shipping Address',
//           'orderNumber': data.orderNumber ?? 'N/A',
//           'productName': productNames,
//           'shippingAddress': shippingAddress,
//           'Breakdown': breakdown,
//           'status': status,
//           'productIds': data.orderItems?.map((item) => item.orderId).toList() ?? [],
//         },
//       ),
//     ]);
//   }).toList();
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     final int rowIndex = effectiveRows.indexOf(row);
//
//
//
//     return DataGridRowAdapter(
//       color: rowIndex % 2 == 0 ? Colors.grey[50] : Colors.white,
//       cells: row.getCells().map<Widget>((dataCell) {
//         if (dataCell.columnName == 'OrderNumber') {
//           // ... existing code ...
//         } else if (dataCell.columnName == 'ProductName') {
//           // ... existing code ...
//         } else if (dataCell.columnName == 'Earnings') {
//           return Container(
//             alignment: Alignment.center,
//             child: Text(
//               dataCell.value?.toString() ?? '\$0.00',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue[800],
//                 fontSize: 13.sp,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Breakdown') {
//           return Container(
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value?.toString() ?? 'N/A',
//               style: TextStyle(
//                 fontSize: 11.sp, // Slightly smaller font for breakdown
//                 color: Colors.black87,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'shippingAddress') {
//           // ... existing code ...
//         } else if (dataCell.columnName == 'Status') {
//           // ... existing code ...
//         } else if (dataCell.columnName == 'Action') {
//           // ... existing code ...
//         } else {
//           return Container(
//             alignment: Alignment.center,
//             child: Text(
//               dataCell.value?.toString() ?? 'N/A',
//               style: TextStyle(fontSize: 13.sp),
//             ),
//           );
//         }
//       }).toList(),
//     );
//
//
//
//
//
//     // return DataGridRowAdapter(
//     //   color: rowIndex % 2 == 0 ? Colors.grey[50] : Colors.white,
//     //   cells: row.getCells().map<Widget>((dataCell) {
//     //     if (dataCell.columnName == 'OrderNumber') {
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Text(
//     //           dataCell.value?.toString() ?? 'N/A',
//     //           style: TextStyle(
//     //             color: Colors.black,
//     //             fontWeight: FontWeight.w500,
//     //             fontSize: 12.sp,
//     //           ),
//     //         ),
//     //       );
//     //     } else if (dataCell.columnName == 'ProductName') {
//     //       return Container(
//     //         alignment: Alignment.centerLeft,
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Text(
//     //           dataCell.value?.toString() ?? 'No Products',
//     //           maxLines: 1,
//     //           overflow: TextOverflow.ellipsis,
//     //           style: TextStyle(
//     //             fontSize: 12.sp,
//     //             color: Colors.black87,
//     //           ),
//     //         ),
//     //       );
//     //     }  else if (dataCell.columnName == 'shippingAddress') {
//     //       return Container(
//     //         alignment: Alignment.centerLeft,
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Text(
//     //           dataCell.value?.toString() ?? 'No Address',
//     //           maxLines: 2, // Allow more lines for address
//     //           overflow: TextOverflow.ellipsis,
//     //           style: TextStyle(
//     //             fontSize: 12.sp,
//     //             color: Colors.black87,
//     //           ),
//     //         ),
//     //       );
//     //     } else if (dataCell.columnName == 'Status') {
//     //       String statusValue = dataCell.value?.toString() ?? 'unknown';
//     //       print(">>>>>>>> Status in buildRow: $statusValue");
//     //
//     //       String statusText;
//     //       Color statusColor;
//     //
//     //       switch (statusValue) {
//     //         case 'confirmed':
//     //           statusText = 'Confirmed';
//     //           statusColor = Colors.green;
//     //           break;
//     //         case 'shipping':
//     //           statusText = 'Shipping';
//     //           statusColor = Colors.orange;
//     //           break;
//     //         case 'completed':
//     //           statusText = 'Completed';
//     //           statusColor = Colors.blue;
//     //           break;
//     //         case 'unknown':
//     //           statusText = 'Pending';
//     //           statusColor = Colors.grey;
//     //           break;
//     //         default:
//     //           statusText = statusValue;
//     //           statusColor = Colors.grey;
//     //       }
//     //
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         margin: const EdgeInsets.all(10),
//     //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//     //         decoration: BoxDecoration(
//     //           color: statusColor.withOpacity(0.1),
//     //           borderRadius: BorderRadius.circular(16),
//     //         ),
//     //         child: Text(
//     //           statusText,
//     //           style: TextStyle(
//     //             color: statusColor,
//     //             fontWeight: FontWeight.w500,
//     //             fontSize: 12.sp,
//     //           ),
//     //         ),
//     //       );
//     //     } else if (dataCell.columnName == 'Action') {
//     //       final actionData = dataCell.value as Map<String, dynamic>?;
//     //       final orderNumber = actionData?['orderNumber'] ?? 'N/A';
//     //       final productName = actionData?['productName'] ?? 'No Products';
//     //       final statusValue = actionData?['status']?.toString() ?? 'pending';
//     //       final buttonText = actionData?['text'] ?? 'Add Shipping Address';
//     //       final productIds = actionData?['productIds'] ?? [];
//     //
//     //       bool isEnabled;
//     //       Color buttonColor;
//     //
//     //       print(">>>>>>>>>>>>>>>>>>>> product button details $statusValue");
//     //
//     //       // Disable button if status is not 'confirmed' or trackingNumber exists
//     //       if (statusValue == 'confirmed' &&
//     //           orderData.any((order) =>
//     //           order.orderNumber == orderNumber &&
//     //               (order.trackingNumber == null || order.trackingNumber!.isEmpty))) {
//     //         isEnabled = true;
//     //         buttonColor = Colors.blue;
//     //       } else {
//     //         isEnabled = false;
//     //         buttonColor = Colors.grey;
//     //       }
//     //
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         child: ElevatedButton(
//     //           onPressed: isEnabled
//     //               ? () {
//     //             print(">>>>>>>> Button pressed with status: $statusValue");
//     //             _showShippingUpdateDialog(
//     //                 context, orderNumber, productName, productIds);
//     //           }
//     //               : null,
//     //           style: ElevatedButton.styleFrom(
//     //             backgroundColor: buttonColor,
//     //             shape: RoundedRectangleBorder(
//     //               borderRadius: BorderRadius.circular(20),
//     //             ),
//     //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     //           ),
//     //           child: Text(
//     //             buttonText,
//     //             style: TextStyle(fontSize: 12.sp, color: Colors.white),
//     //           ),
//     //         ),
//     //       );
//     //     } else if (dataCell.columnName == 'Subtotal') {
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         child: Text(
//     //           dataCell.value?.toString() ?? '\$0.00',
//     //           style: TextStyle(
//     //             fontWeight: FontWeight.bold,
//     //             color: Colors.blue[800],
//     //             fontSize: 13.sp,
//     //           ),
//     //         ),
//     //       );
//     //     } else {
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         child: Text(
//     //           dataCell.value?.toString() ?? 'N/A',
//     //           style: TextStyle(fontSize: 13.sp),
//     //         ),
//     //       );
//     //     }
//     //   }).toList(),
//     // );
//   }
//
//   void _showShippingUpdateDialog(
//       BuildContext context, String orderNumber, String productName, List<dynamic> productIds) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return ShippingUpdateDialog(
//           orderNumber: orderNumber,
//           productName: productName,
//           productIds: productIds,
//           onSuccess: () {
//             onDataUpdated();
//             // Optionally notify listeners for immediate UI update
//             notifyListeners();
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   void notifyListeners() {
//     super.notifyListeners();
//   }
// }













// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:ddavila/features/admin_app/seling/widget/shipping_dialouge_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../model/selling_order_data_model.dart';

class SellingTable extends StatefulWidget {
  final List<SellerOrderDatum> data;
  final VoidCallback onDataUpdated;

  const SellingTable({super.key, required this.data, required this.onDataUpdated});

  @override
  _SellingTableState createState() => _SellingTableState();
}

class _SellingTableState extends State<SellingTable> {
  late DataGridController _dataGridController;
  late OrderDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataGridController = DataGridController();
    _dataSource = OrderDataSource(widget.data, context, widget.onDataUpdated);
  }

  @override
  void didUpdateWidget(covariant SellingTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _dataSource = OrderDataSource(widget.data, context, widget.onDataUpdated);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _dataGridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 24.sp,
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
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SfDataGrid(
                  source: _dataSource,
                  controller: _dataGridController,
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  headerRowHeight: 50.h,
                  rowHeight: 80.h,
                  columns: [
                    GridColumn(
                      columnName: 'OrderNumber',
                      width: 180,
                      label: _buildHeader('Order Number', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'ProductName',
                      width: 180,
                      label: _buildHeader('Product Name', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'Earnings',
                      width: 180,
                      label: _buildHeader('Earnings (After Fees)', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'Breakdown',
                      width: 180,
                      label: _buildHeader('Breakdown', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'shippingAddress',
                      width: 180,
                      label: _buildHeader('Shipping Address', Alignment.centerLeft),
                    ),
                    GridColumn(
                      columnName: 'Status',
                      width: 120,
                      label: _buildHeader('Status', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'Action',
                      width: 160,
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

  Widget _buildHeader(String text, Alignment alignment) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }
}

class OrderDataSource extends DataGridSource {
  List<SellerOrderDatum> orderData;
  final BuildContext context;
  final VoidCallback onDataUpdated;

  OrderDataSource(this.orderData, this.context, this.onDataUpdated);

  void updateData(List<SellerOrderDatum> newData) {
    orderData = newData;
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
    // Calculate earnings (after fees)
    double earnings = 0.0;
    String breakdown = 'N/A';

    if (data.sellerAmount != null) {
      earnings = double.tryParse(data.sellerAmount!) ?? 0.0;
    }

    // Create breakdown string
    if (data.orderItems?.isNotEmpty ?? false) {
      double productFee = 0.0;
      for (var item in data.orderItems!) {
        if (item.subtotal != null) {
          productFee += double.tryParse(item.subtotal!) ?? 0.0;
        }
      }

      double shippingAmount = double.tryParse(data.shippingAmount?.toString() ?? '0') ?? 0.0;
      double platformFee = double.tryParse(data.platformFee?.toString() ?? '0') ?? 0.0;

      breakdown = 'Product fee: \$${productFee.toStringAsFixed(2)}\n'
          'Shipping: \$${shippingAmount.toStringAsFixed(2)}\n'
          'Platform Fee: -\$${platformFee.abs().toStringAsFixed(2)}';
    }

    String productNames = 'No Products';
    if (data.orderItems?.isNotEmpty ?? false) {
      productNames = data.orderItems!
          .map((item) => item.product?.title ?? 'Unknown Product')
          .join(', ');
    }

    // Format shipping address
    String shippingAddress = 'No Address';
    if (data.user != null) {
      final address = data.user!;
      List<String> addressParts = [];

      if (address.address != null && address.address!.isNotEmpty) {
        addressParts.add(address.address!);
      }
      if (address.city != null && address.city!.isNotEmpty) {
        addressParts.add(address.city!);
      }
      if (address.state != null && address.state!.isNotEmpty) {
        addressParts.add(address.state!);
      }
      if (address.country != null && address.country!.isNotEmpty) {
        addressParts.add(address.country!);
      }

      if (addressParts.isNotEmpty) {
        shippingAddress = addressParts.join(', ');
      }
    }

    String status =
        data.status?.toString().split('.').last.toLowerCase() ?? 'unknown';
    print(">>>>>>>> Status from SellerOrderDatum: $status");

    return DataGridRow(cells: [
      DataGridCell<String>(
          columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
      DataGridCell<String>(columnName: 'ProductName', value: productNames),
      DataGridCell<String>(columnName: 'Earnings', value: '\$${earnings.toStringAsFixed(2)}'),
      DataGridCell<String>(columnName: 'Breakdown', value: breakdown),
      DataGridCell<String>(columnName: 'shippingAddress', value: shippingAddress),
      DataGridCell<String>(columnName: 'Status', value: status),
      DataGridCell<Map<String, dynamic>>(
        columnName: 'Action',
        value: {
          'text': 'Add Shipping Address',
          'orderNumber': data.orderNumber ?? 'N/A',
          'productName': productNames,
          'shippingAddress': shippingAddress,
          'Breakdown': breakdown,
          'status': status,
          'productIds': data.orderItems?.map((item) => item.orderId).toList() ?? [],
        },
      ),
    ]);
  }).toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = effectiveRows.indexOf(row);

    return DataGridRowAdapter(
      color: rowIndex % 2 == 0 ? Colors.grey[50] : Colors.white,
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'OrderNumber') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataCell.value?.toString() ?? 'N/A',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          );
        } else if (dataCell.columnName == 'ProductName') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataCell.value?.toString() ?? 'No Products',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
              ),
            ),
          );
        } else if (dataCell.columnName == 'Earnings') {
          return Container(
            alignment: Alignment.center,
            child: Text(
              dataCell.value?.toString() ?? '\$0.00',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
                fontSize: 13.sp,
              ),
            ),
          );
        } else if (dataCell.columnName == 'Breakdown') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataCell.value?.toString() ?? 'N/A',
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black87,
              ),
            ),
          );
        } else if (dataCell.columnName == 'shippingAddress') {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataCell.value?.toString() ?? 'No Address',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
              ),
            ),
          );
        } else if (dataCell.columnName == 'Status') {
          String statusValue = dataCell.value?.toString() ?? 'unknown';
          print(">>>>>>>> Status in buildRow: $statusValue");

          String statusText;
          Color statusColor;

          switch (statusValue) {
            case 'confirmed':
              statusText = 'Confirmed';
              statusColor = Colors.green;
              break;
            case 'shipping':
              statusText = 'Shipping';
              statusColor = Colors.orange;
              break;
            case 'completed':
              statusText = 'Completed';
              statusColor = Colors.blue;
              break;
            case 'unknown':
              statusText = 'Pending';
              statusColor = Colors.grey;
              break;
            default:
              statusText = statusValue;
              statusColor = Colors.grey;
          }

          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          );
        } else if (dataCell.columnName == 'Action') {
          final actionData = dataCell.value as Map<String, dynamic>?;
          final orderNumber = actionData?['orderNumber'] ?? 'N/A';
          final productName = actionData?['productName'] ?? 'No Products';
          final statusValue = actionData?['status']?.toString() ?? 'pending';
          final buttonText = actionData?['text'] ?? 'Add Shipping Address';
          final productIds = actionData?['productIds'] ?? [];

          bool isEnabled;
          Color buttonColor;

          print(">>>>>>>>>>>>>>>>>>>> product button details $statusValue");

          // Disable button if status is not 'confirmed' or trackingNumber exists
          if (statusValue == 'confirmed' &&
              orderData.any((order) =>
              order.orderNumber == orderNumber &&
                  (order.trackingNumber == null || order.trackingNumber!.isEmpty))) {
            isEnabled = true;
            buttonColor = Colors.blue;
          } else {
            isEnabled = false;
            buttonColor = Colors.grey;
          }

          return Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: isEnabled
                  ? () {
                print(">>>>>>>> Button pressed with status: $statusValue");
                _showShippingUpdateDialog(
                    context, orderNumber, productName, productIds);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text(
              dataCell.value?.toString() ?? 'N/A',
              style: TextStyle(fontSize: 13.sp),
            ),
          );
        }
      }).toList(),
    );
  }

  void _showShippingUpdateDialog(
      BuildContext context, String orderNumber, String productName, List<dynamic> productIds) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShippingUpdateDialog(
          orderNumber: orderNumber,
          productName: productName,
          productIds: productIds,
          onSuccess: () {
            onDataUpdated();
            // Optionally notify listeners for immediate UI update
            notifyListeners();
          },
        );
      },
    );
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}