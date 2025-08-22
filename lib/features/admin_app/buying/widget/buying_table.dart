//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// class BuyingTableModel {
//   final String orderNumber;
//   final String productName;
//   final String totalAmount;
//   final String status;
//   final String tracking;
//   final String orderDate;
//   final String action;
//
//   BuyingTableModel(this.orderNumber, this.productName, this.totalAmount, this.status, this.tracking, this.orderDate, this.action);
// }
//
// class BuyingTable extends StatefulWidget {
//   @override
//   _BuyingTableState createState() => _BuyingTableState();
// }
//
// class _BuyingTableState extends State<BuyingTable> {
//   late List<BuyingTableModel> orderData;
//   late DataGridController _dataGridController;
//
//   @override
//   void initState() {
//     super.initState();
//     orderData = [
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Paid', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Paid', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Paid', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'Employment Type', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//       BuyingTableModel('ORD-LWRUMMENM', 'Pokémon All Cards', '\$210.0', 'Confirmed', 'No tracking', '8/7/2025', 'Complete Order'),
//     ];
//     _dataGridController = DataGridController();
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
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: SfDataGrid(
//                   source: OrderDataSource(orderData),
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
//   Widget _buildHeader(String text, Alignment alignment) {
//     return Container(
//       alignment: alignment,
//       padding: EdgeInsets.all(12.0),
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
// class OrderDataSource extends DataGridSource {
//   List<BuyingTableModel> orderData;
//
//   OrderDataSource(this.orderData);
//
//   @override
//   List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
//     return DataGridRow(cells: [
//       DataGridCell<String>(columnName: 'OrderNumber', value: data.orderNumber),
//       DataGridCell<String>(columnName: 'ProductName', value: data.productName),
//       DataGridCell<String>(columnName: 'TotalAmount', value: data.totalAmount),
//       DataGridCell<String>(columnName: 'Status', value: data.status),
//       DataGridCell<String>(columnName: 'Tracking', value: data.tracking),
//       DataGridCell<String>(columnName: 'OrderDate', value: data.orderDate),
//       DataGridCell<String>(columnName: 'Action', value: data.action),
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
//         if (dataCell.columnName == 'OrderNumber' || dataCell.columnName == 'ProductName' || dataCell.columnName == 'OrderDate') {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value.toString(),
//               style: TextStyle(
//                 fontSize: 12.sp,
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
//                 fontSize: 12.sp,
//                 color: Colors.blue[800],
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Status') {
//           Color statusColor = dataCell.value == 'Confirmed' ? Colors.green : Colors.orange;
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
//                 fontSize: 12.sp,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Tracking') {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value.toString(),
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: dataCell.value == 'Employment Type' ? Colors.blue : Colors.black87,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Action') {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(4.0),
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               child: Text(
//                 dataCell.value.toString(),
//                 style: TextStyle(fontSize: 12.sp, color: Colors.white),
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


import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../model/buying_order_data_model.dart' hide State;

class BuyingTable extends StatefulWidget {
  final List<BuyingOrderDatum> data;

  const BuyingTable({
    super.key,
    required this.data,
  });

  @override
  State<BuyingTable> createState() => _BuyingTableState();
}

class _BuyingTableState extends State<BuyingTable> {
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    _dataGridController = DataGridController();
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
                  source: OrderDataSource(widget.data),
                  controller: _dataGridController,
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  columns: [
                    GridColumn(
                      columnName: 'OrderNumber',
                      width: 120,
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
  List<BuyingOrderDatum> orderData;

  OrderDataSource(this.orderData);

  @override
  List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
    // Get product names from order items
    String productNames = data.orderItems?.map((item) => item.product?.title ?? 'Unknown Product').join(', ') ?? 'No Products';

    // Format order date
    String orderDate = data.orderedAt?.toString().split(' ')[0] ?? 'N/A';

    // Get tracking number or default text
    String tracking = data.trackingNumber ?? 'No tracking';

    // Get status with proper formatting
    String status = data.status?.toString().split('.').last ?? 'Pending';
    status = status[0].toUpperCase() + status.substring(1).toLowerCase();

    return DataGridRow(cells: [
      DataGridCell<String>(columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
      DataGridCell<String>(columnName: 'ProductName', value: productNames),
      DataGridCell<String>(columnName: 'TotalAmount', value: '\$${data.totalAmount ?? '0.0'}'),
      DataGridCell<String>(columnName: 'Status', value: status),
      DataGridCell<String>(columnName: 'Tracking', value: tracking),
      DataGridCell<String>(columnName: 'OrderDate', value: orderDate),
      DataGridCell<String>(columnName: 'Action', value: 'Complete Order'),
    ]);
  }).toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = effectiveRows.indexOf(row);

    return DataGridRowAdapter(
      color: rowIndex % 2 == 0 ? Colors.grey[50] : Colors.white,
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'OrderNumber' || dataCell.columnName == 'ProductName' || dataCell.columnName == 'OrderDate') {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          );
        } else if (dataCell.columnName == 'TotalAmount') {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.blue[800],
              ),
            ),
          );
        } else if (dataCell.columnName == 'Status') {
          Color statusColor = dataCell.value == 'Confirmed' ? Colors.green : Colors.orange;
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
        } else if (dataCell.columnName == 'Tracking') {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                fontSize: 12,
                color: dataCell.value == 'No tracking' ? Colors.grey : Colors.black87,
              ),
            ),
          );
        } else if (dataCell.columnName == 'Action') {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: Text(
                dataCell.value.toString(),
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(dataCell.value.toString()),
        );
      }).toList(),
    );
  }
}