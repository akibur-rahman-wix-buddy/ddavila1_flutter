// import 'package:ddavila/networks/api_acess.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../model/buying_order_data_model.dart' hide State;
//
// class BuyingTable extends StatefulWidget {
//   final List<BuyingOrderDatum> data;
//   final VoidCallback onDataUpdated; // Add callback for parent to refresh data
//
//   const BuyingTable({
//     super.key,
//     required this.data,
//     required this.onDataUpdated, // Add this parameter
//   });
//
//   @override
//   State<BuyingTable> createState() => _BuyingTableState();
// }
//
// class _BuyingTableState extends State<BuyingTable> {
//   late DataGridController _dataGridController;
//   Map<int, bool> _loadingStates = {}; // Changed to use int keys for ID
//   List<BuyingOrderDatum> _currentData = []; // Store current data locally
//
//   @override
//   void initState() {
//     super.initState();
//     _dataGridController = DataGridController();
//     _currentData = widget.data; // Initialize with provided data
//
//     // Initialize loading states for all orders using ID
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
//     // Update local data when parent provides new data
//     if (widget.data != oldWidget.data) {
//       setState(() {
//         _currentData = widget.data;
//
//         // Reset loading states using ID
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
//                     _currentData, // Use local data
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
//                     // GridColumn(
//                     //   columnName: 'ProductName',
//                     //   width: 150,
//                     //
//                     //   label: _buildHeader('Product Name', Alignment.center),
//                     // ),
//
//
//
//
//
//
//
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
//
//
//
//   Future<void> _handleButtonPressed(int id, String currentStatus) async {
//     print('Button pressed for order ID: $id with status: $currentStatus');
//
//     // Find the order data
//     final orderIndex = _currentData.indexWhere((order) => order.id == id);
//     if (orderIndex == -1) return;
//
//     final order = _currentData[orderIndex];
//
//     // Show confirmation dialog
//     final bool confirm = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Action'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Are you sure you want to ${currentStatus.toLowerCase() == 'shipping' ? 'accept' : 'complete'} this order?'),
//               SizedBox(height: 16),
//               Text('Order #${order.orderNumber ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text('Product: ${order.orderItems?.first.product?.title ?? 'Unknown'}'),
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
//     // If user cancelled, return early
//     if (confirm != true) {
//       return;
//     }
//
//     setState(() {
//       _loadingStates[id] = true;
//     });
//
//     bool success = await buyingOrderConfirmRx.buyingOrderConfirmInfo(productId: id);
//
//     if (success) {
//       // Notify parent widget to refresh data
//       widget.onDataUpdated();
//
//       // Also update the UI immediately
//       setState(() {
//         // Find and update the specific order status
//         int index = _currentData.indexWhere((order) => order.id == id);
//         if (index != -1) {
//           // Update the status based on current status
//           if (currentStatus.toLowerCase() == 'shipping') {
//             _currentData[index].status = DatumStatus.confirmed;
//           } else if (currentStatus.toLowerCase() == 'confirmed') {
//             _currentData[index].status = DatumStatus.completed;
//           }
//         }
//       });
//
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Order #${order.orderNumber} has been ${currentStatus.toLowerCase() == 'shipping' ? 'accepted' : 'completed'} successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       // Show error message
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
//
//
//
//
//
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
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// class OrderDataSource extends DataGridSource {
//   List<BuyingOrderDatum> orderData;
//   final Map<int, bool> loadingStates; // Changed to use int keys for ID
//   final Function(int, String) onButtonPressed; // Changed to accept int ID
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
//       buttonText = 'Complete';
//       isButtonActive = false; // Changed to true to allow completing the order
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
//         'id': data.id ?? 0, // Use ID instead of orderNumber
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
//           final id = actionData?['id'] ?? 0; // Get ID instead of orderNumber
//           final status = actionData?['status'] ?? 'Pending';
//
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
                    _currentData,
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

  Future<void> _handleButtonPressed(int id, String currentStatus) async {
    print('Button pressed for order ID: $id with status: $currentStatus');

    final orderIndex = _currentData.indexWhere((order) => order.id == id);
    if (orderIndex == -1) return;

    final order = _currentData[orderIndex];

    final bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
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
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
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
  List<BuyingOrderDatum> orderData;
  final Map<int, bool> loadingStates;
  final Function(int, String) onButtonPressed;
  final VoidCallback refresh;

  OrderDataSource(
      this.orderData, {
        required this.loadingStates,
        required this.onButtonPressed,
        required this.refresh,
      });

  @override
  List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
    String productNames = data.orderItems
        ?.map((item) => item.product?.title ?? 'Unknown Product')
        .join(', ') ??
        'No Products';
    String orderDate = data.orderedAt?.toString().split(' ')[0] ?? 'N/A';
    String tracking = data.trackingNumber ?? 'No tracking';
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
      isButtonActive = false; // Allow completing confirmed orders
    } else {
      buttonText = 'Complete Order';
      isButtonActive = false;
    }

    return DataGridRow(cells: [
      DataGridCell<String>(
          columnName: 'OrderNumber', value: data.orderNumber ?? 'N/A'),
      DataGridCell<String>(columnName: 'ProductName', value: productNames),
      DataGridCell<String>(
          columnName: 'TotalAmount',
          value: '\$${data.totalAmount?.toString() ?? '0.00'}'),
      DataGridCell<String>(columnName: 'Status', value: status),
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
          return Container(
            alignment: Alignment.center, // Left-align for better readability
            padding: EdgeInsets.all(8.0),
            child: Text(
              dataCell.value.toString(),
              maxLines: 1, // Restrict to one line
              overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          );
        } else if (dataCell.columnName == 'OrderNumber' ||
            dataCell.columnName == 'OrderDate') {
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
                backgroundColor:
                isButtonActive && !isLoading ? Colors.blue : Colors.grey,
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