// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../model/buying_order_data_model.dart' hide State;
//
// class BuyingTable extends StatefulWidget {
//   final List<BuyingOrderDatum> data;
//
//   const BuyingTable({
//     super.key,
//     required this.data,
//   });
//
//   @override
//   State<BuyingTable> createState() => _BuyingTableState();
// }
//
// class _BuyingTableState extends State<BuyingTable> {
//   late DataGridController _dataGridController;
//   bool isAcceptLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _dataGridController = DataGridController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
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
//                   source: OrderDataSource(widget.data),
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
//
//   OrderDataSource(this.orderData);
//
//   @override
//   List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
//     // Get product names from order items
//     String productNames = data.orderItems?.map((item) => item.product?.title ?? 'Unknown Product').join(', ') ?? 'No Products';
//
//     // Format order date
//     String orderDate = data.orderedAt?.toString().split(' ')[0] ?? 'N/A';
//
//     // Get tracking number or default text
//     String tracking = data.trackingNumber ?? 'No tracking';
//
//     // Get status with proper formatting
//     String status = data.status?.toString().split('.').last ?? 'Pending';
//     status = status[0].toUpperCase() + status.substring(1).toLowerCase();
//
//     // Determine button text and state based on status
//     String buttonText;
//     bool isButtonActive;
//
//     if (status.toLowerCase() == 'completed') {
//       buttonText = 'Completed' ;
//       isButtonActive = false;
//     } else if (status.toLowerCase() == 'shipping') {
//       buttonText = 'Accept';
//       isButtonActive = true;
//     }  else if (status.toLowerCase() == 'confirmed') {
//       buttonText = 'Completed';
//       isButtonActive = false;
//     } else {
//       buttonText = 'Complete Order';
//       isButtonActive = true;
//     }
//
//     return DataGridRow(cells: [
//       DataGridCell<String>(columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
//       DataGridCell<String>(columnName: 'ProductName', value: productNames),
//       DataGridCell<String>(columnName: 'TotalAmount', value: '\$${data.totalAmount?.toString() ?? '0.00'}'),
//       DataGridCell<String>(columnName: 'Status', value: status),
//       DataGridCell<String>(columnName: 'Tracking', value: tracking),
//       DataGridCell<String>(columnName: 'OrderDate', value: orderDate),
//       DataGridCell<Map<String, dynamic>>(columnName: 'Action', value: {
//         'text': buttonText,
//         'isActive': isButtonActive,
//         'orderNumber': data.orderNumber ?? 'N/A',
//         'status': status,
//       }),
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
//           // Improved status color handling
//           Color statusColor;
//           switch (dataCell.value.toString().toLowerCase()) {
//             case 'confirmed':
//               statusColor = Colors.green;
//               break;
//             case 'completed':
//               statusColor = Colors.green;
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
//         } else if (dataCell.columnName == 'Tracking') {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value.toString(),
//               style: TextStyle(
//                 fontSize: 12,
//                 color: dataCell.value == 'No tracking' ? Colors.grey : Colors.black87,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Action') {
//           // Extract button data
//           final actionData = dataCell.value as Map<String, dynamic>?;
//           final buttonText = actionData?['text'] ?? 'Complete Order';
//           final isButtonActive = actionData?['isActive'] ?? true;
//           final orderNumber = actionData?['orderNumber'] ?? 'N/A';
//           final status = actionData?['status'] ?? 'Pending';
//
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(4.0),
//             child: ElevatedButton(
//               onPressed: isButtonActive ? () async {
//
//                 setState(() {
// isButtonActive = true;
//                 });
//                bool success = await buyingOrderConfirmRx.buyingOrderConfirmInfo(productId: orderNumber);
//                if(success){
//                  setState(() {
//                    isButtonActive = true;
//                  });
//                  getBuyingOrderRX.getBuyingOrderRX();
//                  setState(() {
//                    isButtonActive = false;
//                  });
//                  setState(() {
//                    isButtonActive = false;
//                  });
//                }
//
//
//                 print('Button pressed for order: $orderNumber with status: $status');
//                 // You can add your complete order logic here
//               } : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isButtonActive ? Colors.blue : Colors.grey,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               child: Text(
//                 buttonText,
//                 style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.white
//                 ),
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
// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../model/buying_order_data_model.dart' hide State;
//
// class BuyingTable extends StatefulWidget {
//   final List<BuyingOrderDatum> data;
//
//   const BuyingTable({
//     super.key,
//     required this.data,
//   });
//
//   @override
//   State<BuyingTable> createState() => _BuyingTableState();
// }
//
// class _BuyingTableState extends State<BuyingTable> {
//   late DataGridController _dataGridController;
//   Map<String, bool> _loadingStates = {}; // Track loading state for each order
//
//   @override
//   void initState() {
//     super.initState();
//     _dataGridController = DataGridController();
//     // Initialize loading states for all orders
//     for (var order in widget.data) {
//       if (order.orderNumber != null) {
//         _loadingStates[order.orderNumber!] = false;
//       }
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
//                     widget.data,
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
//   Future<void> _handleButtonPressed( dynamic id, dynamic currentStatus) async {
//     print('Button pressed for order: $id with status: $currentStatus');
//     setState(() {
//       _loadingStates[id] = true;
//     });
//
//     bool success = await buyingOrderConfirmRx.buyingOrderConfirmInfo(productId: id);
//
//     if (success) {
//       // Refresh the orders list
//       await getBuyingOrderRX.getBuyingOrderRX();
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
//   final Map<String, bool> loadingStates;
//   final Function(String, String) onButtonPressed;
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
//     // Get product names from order items
//     String productNames = data.orderItems?.map((item) => item.product?.title ?? 'Unknown Product').join(', ') ?? 'No Products';
//
//     // Format order date
//     String orderDate = data.orderedAt?.toString().split(' ')[0] ?? 'N/A';
//
//     // Get tracking number or default text
//     String tracking = data.trackingNumber ?? 'No tracking';
//
//     // Get status with proper formatting
//     String status = data.status?.toString().split('.').last ?? 'Pending';
//     status = status[0].toUpperCase() + status.substring(1).toLowerCase();
//
//     // Determine button text and state based on status
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
//       buttonText = 'Complete ';
//       isButtonActive = false;
//     } else {
//       buttonText = 'Complete Order';
//       isButtonActive = false;
//     }
//
//     return DataGridRow(cells: [
//       DataGridCell<String>(columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
//       DataGridCell<String>(columnName: 'ProductName', value: productNames),
//       DataGridCell<String>(columnName: 'TotalAmount', value: '\$${data.totalAmount?.toString() ?? '0.00'}'),
//       DataGridCell<String>(columnName: 'Status', value: status),
//       DataGridCell<String>(columnName: 'Tracking', value: tracking),
//       DataGridCell<String>(columnName: 'OrderDate', value: orderDate),
//       DataGridCell<Map<String, dynamic>>(columnName: 'Action', value: {
//         'text': buttonText,
//         'isActive': isButtonActive,
//         'orderNumber': data.id ?? 'N/A',
//         'status': status,
//       }),
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
//           // Improved status color handling
//           Color statusColor;
//           switch (dataCell.value.toString().toLowerCase()) {
//             case 'confirmed':
//               statusColor = Colors.green;
//               break;
//             case 'completed':
//               statusColor = Colors.green;
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
//         } else if (dataCell.columnName == 'Tracking') {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               dataCell.value.toString(),
//               style: TextStyle(
//                 fontSize: 12,
//                 color: dataCell.value == 'No tracking' ? Colors.grey : Colors.black87,
//               ),
//             ),
//           );
//         } else if (dataCell.columnName == 'Action') {
//           // Extract button data
//           final actionData = dataCell.value as Map<String, dynamic>?;
//           final buttonText = actionData?['text'] ?? 'Complete Order';
//           final isButtonActive = actionData?['isActive'] ?? true;
//           final orderNumber = actionData?['orderNumber'] ?? 'N/A';
//           final status = actionData?['status'] ?? 'Pending';
//
//           final isLoading = loadingStates[orderNumber] ?? false;
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
//                 await onButtonPressed(orderNumber, status);
//                 refresh(); // Refresh the UI
//               }
//                   : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isButtonActive && !isLoading ? Colors.blue : Colors.grey,
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












import 'package:ddavila/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../model/buying_order_data_model.dart' hide State;

class BuyingTable extends StatefulWidget {
  final List<BuyingOrderDatum> data;
  final VoidCallback onDataUpdated; // Add callback for parent to refresh data

  const BuyingTable({
    super.key,
    required this.data,
    required this.onDataUpdated, // Add this parameter
  });

  @override
  State<BuyingTable> createState() => _BuyingTableState();
}

class _BuyingTableState extends State<BuyingTable> {
  late DataGridController _dataGridController;
  Map<String, bool> _loadingStates = {};
  List<BuyingOrderDatum> _currentData = []; // Store current data locally

  @override
  void initState() {
    super.initState();
    _dataGridController = DataGridController();
    _currentData = widget.data; // Initialize with provided data

    // Initialize loading states for all orders
    for (var order in _currentData) {
      if (order.orderNumber != null) {
        _loadingStates[order.orderNumber!] = false;
      }
    }
  }

  @override
  void didUpdateWidget(BuyingTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update local data when parent provides new data
    if (widget.data != oldWidget.data) {
      setState(() {
        _currentData = widget.data;

        // Reset loading states
        _loadingStates.clear();
        for (var order in _currentData) {
          if (order.orderNumber != null) {
            _loadingStates[order.orderNumber!] = false;
          }
        }
      });
    }
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
                  source: OrderDataSource(
                    _currentData, // Use local data
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

  Future<void> _handleButtonPressed(String id, String currentStatus) async {
    print('Button pressed for order: $id with status: $currentStatus');
    setState(() {
      _loadingStates[id] = true;
    });

    bool success = await buyingOrderConfirmRx.buyingOrderConfirmInfo(productId: int.parse(id));

    if (success) {
      // Notify parent widget to refresh data
      widget.onDataUpdated();

      // Also update the UI immediately
      setState(() {
        // Find and update the specific order status
        int index = _currentData.indexWhere((order) => order.orderNumber == id);
        if (index != -1) {
          // Update the status based on current status
          if (currentStatus.toLowerCase() == 'shipping') {
            _currentData[index].status = 'confirmed'
            as DatumStatus?; // Or whatever status comes after shipping
          }
          // Add other status transitions as needed
        }
      });
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
  List<BuyingOrderDatum> orderData;
  final Map<String, bool> loadingStates;
  final Function(String, String) onButtonPressed;
  final VoidCallback refresh;

  OrderDataSource(
      this.orderData, {
        required this.loadingStates,
        required this.onButtonPressed,
        required this.refresh,
      });

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

    // Determine button text and state based on status
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
      isButtonActive = true; // Changed to true to allow completing the order
    } else {
      buttonText = 'Complete Order';
      isButtonActive = false;
    }

    return DataGridRow(cells: [
      DataGridCell<String>(columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
      DataGridCell<String>(columnName: 'ProductName', value: productNames),
      DataGridCell<String>(columnName: 'TotalAmount', value: '\$${data.totalAmount?.toString() ?? '0.00'}'),
      DataGridCell<String>(columnName: 'Status', value: status),
      DataGridCell<String>(columnName: 'Tracking', value: tracking),
      DataGridCell<String>(columnName: 'OrderDate', value: orderDate),
      DataGridCell<Map<String, dynamic>>(columnName: 'Action', value: {
        'text': buttonText,
        'isActive': isButtonActive,
        'orderNumber': data.orderNumber ?? 'N/A', // Use orderNumber as string
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
          // Improved status color handling
          Color statusColor;
          switch (dataCell.value.toString().toLowerCase()) {
            case 'confirmed':
              statusColor = Colors.green;
              break;
            case 'completed':
              statusColor = Colors.green;
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
          // Extract button data
          final actionData = dataCell.value as Map<String, dynamic>?;
          final buttonText = actionData?['text'] ?? 'Complete Order';
          final isButtonActive = actionData?['isActive'] ?? true;
          final orderNumber = actionData?['orderNumber'] ?? 'N/A';
          final status = actionData?['status'] ?? 'Pending';

          final isLoading = loadingStates[orderNumber] ?? false;

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
                await onButtonPressed(orderNumber, status);
                refresh(); // Refresh the UI
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonActive && !isLoading ? Colors.blue : Colors.grey,
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
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(dataCell.value.toString()),
        );
      }).toList(),
    );
  }
}