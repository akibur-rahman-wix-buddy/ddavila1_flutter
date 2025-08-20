import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AdminAuctionData {
  final int orderId;
  final String title;
  final String status;
  final int bids;
  final String timeLeft;
  final String dueDate;
  final String imageUrl;

  AdminAuctionData(this.orderId, this.title, this.status, this.bids, this.timeLeft, this.dueDate, this.imageUrl);
}

class AuctionDataGridData extends StatefulWidget {
  @override
  _AuctionDataGridDataState createState() => _AuctionDataGridDataState();
}

class _AuctionDataGridDataState extends State<AuctionDataGridData> {
  late List<AdminAuctionData> auctionData;
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    auctionData = [
      AdminAuctionData(118, 'Pokemon All Cards', 'Live', 21, '1h 12m', 'Aug 9, 2025', ''),
      AdminAuctionData(112, 'Jason vs Leatherface #1-1995 Topps Comics–Low Grade Reader Copy', 'Live', 1, '1h 12m', 'Aug 13, 2025', ''),
      AdminAuctionData(109, 'Sport', 'Live', 3, '1h 12m', 'Jul 31, 2025', ''),
      AdminAuctionData(102, 'USA Comics #17 Captain America WWII Golden Age Marvel Timely Comic', 'Live', 833, '1h 12m', 'Jul 31, 2025', ''),
      AdminAuctionData(98, 'based on this Baseball 20 Autographs', 'Live', 212, '1h 12m', 'Jul 29, 2025', ''),
    ];
    _dataGridController = DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        
        
        children: [

          Text(
            'Recent Auction ',
            style: TextStyle(
              color: const Color(0xFF0B0C18),
              fontSize: 20,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w600,
              height: 1.10,
              letterSpacing: 0.20,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          
          SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.horizontal,
            headerGridLinesVisibility: GridLinesVisibility.horizontal,
            source: AuctionDataSource(auctionData),
            columnWidthMode: ColumnWidthMode.fill,
            controller: _dataGridController,
            columns: [
              GridColumn(
                columnName: 'orderId',
                width: 100,
                label: _buildHeader('ORDER ID', Alignment.center),
              ),
              GridColumn(
                columnName: 'image',
                width: 80,
                label: _buildHeader('IMAGE', Alignment.center),
              ),
              GridColumn(
                columnName: 'title',
                width: 250,
                label: _buildHeader('TITLE', Alignment.centerLeft),
              ),
              GridColumn(
                columnName: 'status',
                width: 100,
                label: _buildHeader('STATUS', Alignment.center),
              ),
              GridColumn(
                columnName: 'bids',
                width: 80,
                label: _buildHeader('BIDS', Alignment.centerRight),
              ),
              GridColumn(
                columnName: 'timeLeft',
                width: 100,
                label: _buildHeader('TIME LEFT', Alignment.center),
              ),
              GridColumn(
                columnName: 'dueDate',
                width: 120,
                label: _buildHeader('DUE DATE', Alignment.center),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String text, Alignment alignment) {
    return Container(
      padding: EdgeInsets.all(12.0),
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}

class AuctionDataSource extends DataGridSource {
  List<AdminAuctionData> auctionData;

  AuctionDataSource(this.auctionData);

  @override
  List<DataGridRow> get rows => auctionData.map<DataGridRow>((data) {
    return DataGridRow(cells: [
      DataGridCell<int>(columnName: 'orderId', value: data.orderId),
      DataGridCell<String>(columnName: 'image', value: data.imageUrl),
      DataGridCell<String>(columnName: 'title', value: data.title),
      DataGridCell<String>(columnName: 'status', value: data.status),
      DataGridCell<int>(columnName: 'bids', value: data.bids),
      DataGridCell<String>(columnName: 'timeLeft', value: data.timeLeft),
      DataGridCell<String>(columnName: 'dueDate', value: data.dueDate),
    ]);
  }).toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = effectiveRows.indexOf(row);

    Color getRowBackgroundColor() {
      return rowIndex % 2 == 0 ? Colors.grey[50]! : Colors.white;
    }

    return DataGridRowAdapter(
      color: getRowBackgroundColor(),
      cells: row.getCells().map<Widget>((dataCell) {
        Widget cellContent;

        if (dataCell.columnName == 'status') {
          final status = dataCell.value.toString();
          cellContent = Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
            ),
          );
        } else if (dataCell.columnName == 'bids') {
          cellContent = Text(
            dataCell.value.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
            textAlign: TextAlign.right,
          );
        } else if (dataCell.columnName == 'image') {
          cellContent = dataCell.value != ''
              ? Image.network(dataCell.value, width: 30, height: 30, fit: BoxFit.cover)
              : Container(
            width: 30,
            height: 30,
            color: Colors.grey[300],
            child: Icon(Icons.image, color: Colors.grey[600], size: 18),
          );
        } else {
          cellContent = Text(
            dataCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          );
        }

        return Container(
          padding: EdgeInsets.all(12.0),
          alignment: dataCell.columnName == 'bids'
              ? Alignment.centerRight
              : (dataCell.columnName == 'title'
              ? Alignment.centerLeft
              : Alignment.center),
          child: cellContent,
        );
      }).toList(),
    );
  }
}
