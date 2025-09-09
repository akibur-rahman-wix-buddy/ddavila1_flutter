
// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:ddavila/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ddavila/features/admin_app/bit_history/model/bit_history_data_model.dart';

class BidHistoryDataSource extends DataGridSource {
  final List<BidHistoryData> bidHistoryData;
  final BuildContext context;
  final VoidCallback refresh;
  final Function(BidHistoryData)? onRowTap;

  BidHistoryDataSource({
    required this.bidHistoryData,
    required this.context,
    required this.refresh,
    this.onRowTap,
  });

  @override
  List<DataGridRow> get rows => bidHistoryData.map<DataGridRow>((data) {
    String productName = data.product?.title.toString() ?? 'Unknown Product';
    String amount = '\$${data.amount?.toStringAsFixed(2) ?? '0.00'}';
    String isWinner = data.isWinner == 1 ? 'Yes' : 'No';
    String createdAt = data.createdAt?.split(' ')[0] ?? 'N/A';

    return DataGridRow(
      cells: [
        DataGridCell<String>(columnName: 'ProductName', value: productName),
        DataGridCell<String>(columnName: 'Amount', value: amount),
        DataGridCell<String>(columnName: 'IsWinner', value: isWinner),
        DataGridCell<String>(columnName: 'CreatedAt', value: createdAt),
        DataGridCell<String>(
            columnName: 'ProductImage',
            value: data.product?.images?.isNotEmpty == true
                ? image_url + data.product!.images!.first
                : ''
        ),
      ],
    );
  }).toList();


  String formatDate(String isoDate) {
    try {
      DateTime date = DateTime.parse(isoDate);
      return "${date.month}/${date.day}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }


  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = effectiveRows.indexOf(row);
    final bidData = bidHistoryData[rowIndex];

    return DataGridRowAdapter(
      color: rowIndex % 2 == 0 ? Colors.grey[50] : Colors.white,
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'ProductImage') {
          final imageUrl = dataCell.value.toString();
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.image, size: 40, color: Colors.grey[400]),
            )
                : Icon(Icons.image, size: 40, color: Colors.grey[400]),
          );
        } else if (dataCell.columnName == 'ProductName') {
          return Container(
            width: 200, // Fixed width as requested
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              dataCell.value.toString(),
              maxLines: 2, // Allow up to 4 lines
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          );
        } else if (dataCell.columnName == 'CreatedAt') {
          return _cell(text: formatDate(dataCell.value.toString()), alignment: Alignment.center);
        } else if (dataCell.columnName == 'Amount') {
          return _cell(
            text: dataCell.value.toString(),
            alignment: Alignment.center,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          );
        } else if (dataCell.columnName == 'IsWinner') {
          return Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: dataCell.value.toString() == 'Yes'
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(
                color: dataCell.value.toString() == 'Yes' ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 12,
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
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: style ??
            const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
      ),
    );
  }
}