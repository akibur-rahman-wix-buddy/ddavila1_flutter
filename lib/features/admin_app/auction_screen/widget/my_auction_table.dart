import 'package:ddavila/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AuctionData {
  final String productName;
  final String bidAmount;
  final String winStatus;
  final String date;
  final String imageUrl;

  AuctionData(this.productName, this.bidAmount, this.winStatus, this.date, this.imageUrl);
}

class MyAuctionTable extends StatefulWidget {
  @override
  _MyAuctionTableState createState() => _MyAuctionTableState();
}

class _MyAuctionTableState extends State<MyAuctionTable> {
  late List<AuctionData> auctionData;
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    auctionData = [
      AuctionData('Pokemon All Cards', '\$704', 'Not won', '2030-09-28', ''),
      AuctionData('Charizard Holo', '\$1,250', 'Won', '2030-10-15', ''),
      AuctionData('Shadowless Blastoise', '\$980', 'Not won', '2030-10-22', ''),
      AuctionData('First Edition Venusaur', '\$1,550', 'Won', '2030-11-05', ''),
      AuctionData('Mewtwo EX', '\$620', 'Not won', '2030-11-12', ''),
      AuctionData('Pikachu Illustrator', '\$2,300', 'Not won', '2030-11-18', ''),
      AuctionData('Gold Star Umbreon', '\$1,800', 'Won', '2030-12-03', ''),
      AuctionData('Complete Base Set', '\$3,400', 'Not won', '2030-12-10', ''),
      AuctionData('Shining Charizard', '\$1,100', 'Won', '2030-12-17', ''),
      AuctionData('Japanese Promo Cards', '\$890', 'Not won', '2030-12-24', ''),
      AuctionData('Team Rocket Set', '\$1,450', 'Won', '2031-01-05', ''),
      AuctionData('Gym Heroes Complete', '\$1,750', 'Not won', '2031-01-12', ''),
      AuctionData('Neo Genesis Booster Box', '\$2,200', 'Won', '2031-01-20', ''),
      AuctionData('Base Set Booster Pack', '\$350', 'Not won', '2031-01-28', ''),
      AuctionData('Shadowless Charizard', '\$3,500', 'Won', '2031-02-05', ''),
    ];
    _dataGridController = DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Recent Auction',
                style: TextStyle(
                  color: const Color(0xFF0B0C18),
                  fontSize: 24.sp,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.10,
                  letterSpacing: 0.20,
                ),
              ),
            ),
            // UIHelper.verticalSpace(12.h),

            // Expanded DataGrid to take remaining space
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
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  source: AuctionDataSource(auctionData),
                  columnWidthMode: ColumnWidthMode.fill,
                  controller: _dataGridController,
                  columns: [
                    GridColumn(
                      columnName: 'productName',
                      width: 200,
                      label: _buildHeader('Product name', Alignment.centerLeft),
                    ),
                    GridColumn(
                      columnName: 'image',
                      width: 80,
                      label: _buildHeader('Image', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'bidAmount',
                      width: 120,
                      label: _buildHeader('Bid Amount', Alignment.centerRight),
                    ),
                    GridColumn(
                      columnName: 'winStatus',
                      width: 120,
                      label: _buildHeader('Win Status', Alignment.center),
                    ),
                    GridColumn(
                      columnName: 'date',
                      width: 120,
                      label: _buildHeader('Date', Alignment.center),
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
      padding: EdgeInsets.all(16.0),
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[800],
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class AuctionDataSource extends DataGridSource {
  List<AuctionData> auctionData;

  AuctionDataSource(this.auctionData);

  @override
  List<DataGridRow> get rows => auctionData.map<DataGridRow>((data) {
    return DataGridRow(cells: [
      DataGridCell<String>(columnName: 'productName', value: data.productName),
      DataGridCell<String>(columnName: 'image', value: data.imageUrl),
      DataGridCell<String>(columnName: 'bidAmount', value: data.bidAmount),
      DataGridCell<String>(columnName: 'winStatus', value: data.winStatus),
      DataGridCell<String>(columnName: 'date', value: data.date),
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

        if (dataCell.columnName == 'winStatus') {
          final status = dataCell.value.toString();
          final isWon = status == 'Won';
          cellContent = Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isWon ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isWon ? Colors.green : Colors.orange[800],
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          );
        } else if (dataCell.columnName == 'bidAmount') {
          cellContent = Text(
            dataCell.value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.right,
          );
        } else if (dataCell.columnName == 'image') {
          cellContent = dataCell.value != null && dataCell.value.toString().isNotEmpty
              ? Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.image, color: Colors.grey[500], size: 20.sp),
          )
              : Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.image, color: Colors.grey[500], size: 20.sp),
          );
        } else if (dataCell.columnName == 'productName') {
          cellContent = Text(
            dataCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.sp),
          );
        } else {
          cellContent = Text(
            dataCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.sp),
          );
        }

        return Container(
          padding: EdgeInsets.all(12.0),
          alignment: dataCell.columnName == 'bidAmount'
              ? Alignment.centerRight
              : (dataCell.columnName == 'productName'
              ? Alignment.centerLeft
              : Alignment.center),
          child: cellContent,
        );
      }).toList(),
    );
  }
}