// import 'dart:async';
//
// import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
// import 'package:ddavila/networks/endpoints.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// class AuctionDataGridData extends StatefulWidget {
//   final List<RecentAuction> data;
//
//   const AuctionDataGridData({super.key, required this.data});
//
//   @override
//   _AuctionDataGridDataState createState() => _AuctionDataGridDataState();
// }
//
// class _AuctionDataGridDataState extends State<AuctionDataGridData> {
//   late AuctionDataSource _dataSource;
//   late DataGridController _dataGridController;
//
//   @override
//   void initState() {
//     super.initState();
//     _dataSource = AuctionDataSource(widget.data);
//     _dataGridController = DataGridController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Recent Auctions',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 12),
//           SfDataGrid(
//             gridLinesVisibility: GridLinesVisibility.horizontal,
//             headerGridLinesVisibility: GridLinesVisibility.horizontal,
//             source: _dataSource,
//             columnWidthMode: ColumnWidthMode.fill,
//             controller: _dataGridController,
//             columns: [
//               GridColumn(
//                 columnName: 'id',
//                 width: 100,
//                 label: _buildHeader('ID', Alignment.center),
//               ),
//               GridColumn(
//                 columnName: 'image',
//                 width: 80,
//                 label: _buildHeader('IMAGE', Alignment.center),
//               ),
//               GridColumn(
//                 columnName: 'title',
//                 width: 150,
//                 label: _buildHeader('TITLE', Alignment.center),
//               ),
//               GridColumn(
//                 columnName: 'startingPrice',
//                 width: 100,
//                 label: _buildHeader('BIDS', Alignment.center),
//               ),
//               GridColumn(
//                 columnName: 'timeLeft',
//                 width: 100,
//                 label: _buildHeader('TIME LEFT', Alignment.center),
//               ),
//               GridColumn(
//                 columnName: 'endDate',
//                 width: 120,
//                 label: _buildHeader('END DATE', Alignment.center),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader(String text, Alignment alignment) {
//     return Container(
//       padding: const EdgeInsets.all(12.0),
//       alignment: alignment,
//       child: Text(
//         text,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.grey[800],
//         ),
//       ),
//     );
//   }
// }
//
// class AuctionDataSource extends DataGridSource {
//   final List<RecentAuction> auctions;
//
//   AuctionDataSource(this.auctions);
//
//   @override
//   List<DataGridRow> get rows => auctions.map<DataGridRow>((auction) {
//     return DataGridRow(cells: [
//       DataGridCell<int>(columnName: 'id', value: auction.id ?? 0),
//       DataGridCell<String>(
//           columnName: 'image',
//           value: auction.images?.isNotEmpty == true
//               ? auction.images!.first
//               : ''),
//       DataGridCell<String>(
//           columnName: 'title', value: auction.title ?? 'Untitled'),
//       DataGridCell<int>(
//           columnName: 'startingPrice', value: auction.startingPrice ?? 0),
//       DataGridCell<String>(
//           columnName: 'timeLeft',
//           value: _calculateTimeLeft(auction.auctionEndAt) // Use your existing function
//       ),
//       DataGridCell<String>(
//           columnName: 'endDate',
//           value: auction.auctionEndAt != null
//               ? _formatDate(auction.auctionEndAt!)
//               : ''),
//     ]);
//   }).toList();
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     final int rowIndex = effectiveRows.indexOf(row);
//
//     Color getRowBackgroundColor() {
//       return rowIndex % 2 == 0 ? Colors.grey[50]! : Colors.white;
//     }
//
//     return DataGridRowAdapter(
//       color: getRowBackgroundColor(),
//       cells: row.getCells().map<Widget>((dataCell) {
//         Widget cellContent;
//
//         if (dataCell.columnName == 'image') {
//           cellContent = dataCell.value != ''
//               ? ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: Image.network(
//               "$image_url${dataCell.value}",
//               width: 30,
//               height: 30,
//               fit: BoxFit.cover,
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return Container(
//                   width: 30,
//                   height: 30,
//                   alignment: Alignment.center,
//                   child: const SizedBox(
//                     width: 16,
//                     height: 16,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   ),
//                 );
//               },
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   width: 30,
//                   height: 30,
//                   color: Colors.grey[300],
//                   child: const Icon(Icons.broken_image,
//                       color: Colors.grey, size: 18),
//                 );
//               },
//             ),
//           )
//               : Container(
//             width: 30,
//             height: 30,
//             color: Colors.grey[300],
//             child: const Icon(Icons.image,
//                 color: Colors.grey, size: 18),
//           );
//         } else if (dataCell.columnName == 'startingPrice') {
//           cellContent = Text(
//             "\$${dataCell.value}",
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.blue),
//             textAlign: TextAlign.center,
//           );
//         } else {
//           cellContent = Text(
//             dataCell.value.toString(),
//             overflow: TextOverflow.ellipsis,
//           );
//         }
//
//         return Container(
//           padding: const EdgeInsets.all(12.0),
//           alignment: dataCell.columnName == 'startingPrice'
//               ? Alignment.center
//               : (dataCell.columnName == 'title'
//               ? Alignment.center
//               : Alignment.center),
//           child: cellContent,
//         );
//       }).toList(),
//     );
//   }
//
//
//
//   String _calculateTimeLeft(DateTime endTime) {
//     final now = DateTime.now();
//     final diff = endTime.difference(now);
//
//     if (diff.isNegative) return "Ended";
//
//     final totalSeconds = diff.inSeconds;
//     final seconds = totalSeconds % 60;
//     final totalMinutes = totalSeconds ~/ 60;
//     final minutes = totalMinutes % 60;
//     final totalHours = totalMinutes ~/ 60;
//     final hours = totalHours % 24;
//     final days = totalHours ~/ 24;
//     final months = days ~/ 30;
//
//     final parts = <String>[];
//     if (months > 0) parts.add('${months}mo');
//     if (days % 30 > 0) parts.add('${days % 30}d');
//     if (hours > 0) parts.add('${hours}h');
//     if (minutes > 0) parts.add('${minutes}m');
//     parts.add('${seconds}s');
//
//     return parts.join(' ');
//   }
//
//
//
//   // static String _calculateTimeLeft(DateTime? endTime) {
//   //   if (endTime == null) return '';
//   //   final diff = endTime.difference(DateTime.now());
//   //   if (diff.isNegative) return "Ended";
//   //   final hours = diff.inHours;
//   //   final minutes = diff.inMinutes % 60;
//   //   return "${hours}h ${minutes}m";
//   // }
//
//   static String _formatDate(DateTime date) {
//     return "${date.day}-${date.month}-${date.year}";
//   }
// }
//


import 'dart:async';

import 'package:ddavila/features/admin_app/dashboard_screen/model/admin_dash_model.dart';
import 'package:ddavila/networks/endpoints.dart';
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _dataSource = AuctionDataSource(widget.data);
    _dataGridController = DataGridController();
    _startTimer();
  }

  void _startTimer() {
    // Update every second for live countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_dataSource.mounted) {
        _dataSource.notifyListeners(); // Refresh the DataGrid
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _dataSource.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AuctionDataGridData oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update data source when widget data changes
    _dataSource.updateAuctions(widget.data);
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
                label: _buildHeader('ORDER ID', Alignment.center),
              ),
              GridColumn(
                columnName: 'image',
                width: 80,
                label: _buildHeader('IMAGE', Alignment.center),
              ),
              GridColumn(
                columnName: 'title',
                width: 150,
                label: _buildHeader('TITLE', Alignment.center),
              ),
              GridColumn(
                columnName: 'startingPrice',
                width: 100,
                label: _buildHeader('BIDS', Alignment.center),
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
  List<RecentAuction> auctions;
  Timer? _internalTimer;
  bool _mounted = true;

  AuctionDataSource(this.auctions) {
    _startInternalTimer();
  }

  void _startInternalTimer() {
    _internalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_mounted) {
        notifyListeners(); // Refresh the DataGrid every second
      }
    });
  }

  void updateAuctions(List<RecentAuction> newAuctions) {
    auctions = newAuctions;
    if (_mounted) {
      notifyListeners();
    }
  }

  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = false;
    _internalTimer?.cancel();
    super.dispose();
  }

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
          value: _calculateTimeLeft(auction.auctionEndAt)
      ),
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
              "$image_url${dataCell.value}",
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
                color: Colors.blue),
            textAlign: TextAlign.center,
          );
        } else if (dataCell.columnName == 'timeLeft') {
          // Special styling for timeLeft column
          final timeLeft = dataCell.value.toString();
          Color timeColor = Colors.blue; // Default color

          if (timeLeft == "Ended") {
            timeColor = Colors.red;
          } else if (timeLeft.contains("h") || timeLeft.contains("d") || timeLeft.contains("mo")) {
            // If there are hours, days, or months left
            timeColor = Colors.black87;
          } else {
            // If only minutes and seconds left (urgent)
            timeColor = Colors.orange;
          }

          cellContent = Text(
            timeLeft,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: timeColor,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          );
        } else {
          cellContent = Text(
            dataCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          );
        }

        return Container(
          padding: const EdgeInsets.all(12.0),
          alignment: dataCell.columnName == 'startingPrice' || dataCell.columnName == 'timeLeft'
              ? Alignment.center
              : (dataCell.columnName == 'title'
              ? Alignment.center
              : Alignment.center),
          child: cellContent,
        );
      }).toList(),
    );
  }

  String _calculateTimeLeft(DateTime? endTime) {
    if (endTime == null) return 'No date';

    final now = DateTime.now();
    final diff = endTime.difference(now);

    if (diff.isNegative) return "Ended";

    final totalSeconds = diff.inSeconds;
    final seconds = totalSeconds % 60;
    final totalMinutes = totalSeconds ~/ 60;
    final minutes = totalMinutes % 60;
    final totalHours = totalMinutes ~/ 60;
    final hours = totalHours % 24;
    final days = totalHours ~/ 24;
    final months = days ~/ 30;

    final parts = <String>[];
    if (months > 0) parts.add('${months}mo');
    if (days % 30 > 0) parts.add('${days % 30}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    parts.add('${seconds.toString().padLeft(2, '0')}s'); // Pad seconds with leading zero

    return parts.join(' ');
  }

  static String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}