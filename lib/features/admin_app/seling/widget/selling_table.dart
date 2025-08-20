import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SellingTableModel {
  final String orderNumber;
  final String productName;
  final String subtotal;
  final String status;

  SellingTableModel(this.orderNumber, this.productName, this.subtotal, this.status);
}

class SellingTable extends StatefulWidget {
  @override
  _SellingTableState createState() => _SellingTableState();
}

class _SellingTableState extends State<SellingTable> {
  late List<SellingTableModel> orderData;
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    orderData = List.generate(
      12,
          (index) => SellingTableModel(
        'ORD-LWRUMMENIN',
        'Pokémon All Cards',
        '\$210.0',
        'Confirmed',
      ),
    );
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
            // Header Title
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

            // DataGrid
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
                  source: OrderDataSource(orderData),
                  controller: _dataGridController,
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
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
                      columnName: 'Subtotal',
                      width: 120,
                      label: _buildHeader('Subtotal', Alignment.center),
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
      padding: EdgeInsets.all(12.0),
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
  List<SellingTableModel> orderData;

  OrderDataSource(this.orderData);

  @override
  List<DataGridRow> get rows => orderData.map<DataGridRow>((data) {
    return DataGridRow(cells: [

     DataGridCell<String>(columnName: 'OrderNumber', value: data.orderNumber,),
      DataGridCell<String>(columnName: 'ProductName', value: data.productName),
      DataGridCell<String>(columnName: 'Subtotal', value: data.subtotal),
      DataGridCell<String>(columnName: 'Status', value: data.status),
      DataGridCell<String>(columnName: 'Action', value: 'Update Shipping'),
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

            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          );
        }
        else if (dataCell.columnName == 'Status') {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          );
        } else if (dataCell.columnName == 'Action') {
          return Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                dataCell.value.toString(),
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ),
          );
        } else if (dataCell.columnName == 'Subtotal') {
          return Container(
            alignment: Alignment.center,
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
                fontSize: 13.sp,
              ),
            ),
          );
        } else if (dataCell.columnName == 'OrderNumber') {
          return Container(
            alignment: Alignment.centerLeft,
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(fontSize: 13.sp),
            ),
          );
        }
      }).toList(),
    );
  }
}
