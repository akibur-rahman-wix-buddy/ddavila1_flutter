import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AuctionDataGridData extends StatefulWidget {
  final List<RecentAuction> data;

  const AuctionDataGridData({super.key, required this.data});

  @override
  _AuctionDataGridDataState createState() => _AuctionDataGridDataState();
}

class _AuctionDataGridDataState extends State<AuctionDataGridData> {
  late AuctionDataSource _dataSource;
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    _dataSource = AuctionDataSource(widget.data);
    _dataGridController = DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Auctions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.horizontal,
            headerGridLinesVisibility: GridLinesVisibility.horizontal,
            source: _dataSource,
            columnWidthMode: ColumnWidthMode.fill,
            controller: _dataGridController,
            columns: [
              GridColumn(
                columnName: 'id',
                width: 100,
                label: _buildHeader('ID', Alignment.center),
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
                columnName: 'startingPrice',
                width: 120,
                label: _buildHeader('START PRICE', Alignment.centerRight),
              ),
              GridColumn(
                columnName: 'timeLeft',
                width: 100,
                label: _buildHeader('TIME LEFT', Alignment.center),
              ),
              GridColumn(
                columnName: 'endDate',
                width: 120,
                label: _buildHeader('END DATE', Alignment.center),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String text, Alignment alignment) {
    return Container(
      padding: const EdgeInsets.all(12.0),
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
  final List<RecentAuction> auctions;

  AuctionDataSource(this.auctions);

  @override
  List<DataGridRow> get rows => auctions.map<DataGridRow>((auction) {
    return DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: auction.id ?? 0),
      DataGridCell<String>(
          columnName: 'image',
          value: auction.images?.isNotEmpty == true
              ? auction.images!.first
              : ''),
      DataGridCell<String>(
          columnName: 'title', value: auction.title ?? 'Untitled'),
      DataGridCell<int>(
          columnName: 'startingPrice', value: auction.startingPrice ?? 0),
      DataGridCell<String>(
          columnName: 'timeLeft',
          value: _calculateTimeLeft(auction.auctionEndAt)),
      DataGridCell<String>(
          columnName: 'endDate',
          value: auction.auctionEndAt != null
              ? _formatDate(auction.auctionEndAt!)
              : ''),
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

        if (dataCell.columnName == 'image') {
          cellContent = dataCell.value != ''
              ? ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              dataCell.value,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 30,
                  height: 30,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image,
                      color: Colors.grey, size: 18),
                );
              },
            ),
          )
              : Container(
            width: 30,
            height: 30,
            color: Colors.grey[300],
            child: const Icon(Icons.image,
                color: Colors.grey, size: 18),
          );
        } else if (dataCell.columnName == 'startingPrice') {
          cellContent = Text(
            "\$${dataCell.value}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue),
            textAlign: TextAlign.right,
          );
        } else {
          cellContent = Text(
            dataCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          );
        }

        return Container(
          padding: const EdgeInsets.all(12.0),
          alignment: dataCell.columnName == 'startingPrice'
              ? Alignment.centerRight
              : (dataCell.columnName == 'title'
              ? Alignment.centerLeft
              : Alignment.center),
          child: cellContent,
        );
      }).toList(),
    );
  }

  static String _calculateTimeLeft(DateTime? endTime) {
    if (endTime == null) return '';
    final diff = endTime.difference(DateTime.now());
    if (diff.isNegative) return "Ended";
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    return "${hours}h ${minutes}m";
  }

  static String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}
