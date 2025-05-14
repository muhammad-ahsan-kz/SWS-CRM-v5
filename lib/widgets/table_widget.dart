import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class TableWidget extends StatelessWidget {
  final List<String> columnNamesList;
  final List<Map<String, dynamic>> rowsValuesList;
  final double cellHorizontalPadding;
  final double cellVerticalPadding;
  final double tableHeight;
  final double tableWidth;
  final double rowTopBottomPadding;
  final Widget Function(Map<String, dynamic> rowData, int index)? actionBuilder;

  const TableWidget({
    super.key,
    required this.columnNamesList,
    required this.rowsValuesList,
    this.cellHorizontalPadding = 8.0,
    this.cellVerticalPadding = 8.0,
    this.tableHeight = 500,
    this.tableWidth = 600,
    this.rowTopBottomPadding = 5,
    this.actionBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final hasActions = actionBuilder != null;
    final horizontalScrollController = ScrollController();

    return Container(
      // width: tableWidth,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.boxBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: true,
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: Scrollbar(
          thumbVisibility: true,
          controller: horizontalScrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: horizontalScrollController,
            child: Column(
              children: [
                // Table Header
                Container(
                  width: tableWidth,
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,

                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.boxBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...columnNamesList.map(
                        (col) => Text(
                          col,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreenText,
                          ),
                        ),
                      ),
                      if (hasActions)
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Actions",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreenText,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Scrollable Table Rows
                rowsValuesList.isEmpty
                    ? SizedBox(
                      height: tableHeight,
                      width: tableWidth,
                      child: Center(
                        child: Text(
                          'No Items Available !',
                          style: TextStyle(color: AppColors.darkGreenText),
                        ),
                      ),
                    )
                    : SizedBox(
                      height: tableHeight,
                      width: tableWidth,
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => SizedBox(height: 10),
                        itemCount: rowsValuesList.length,
                        itemBuilder: (context, index) {
                          final row = rowsValuesList[index];
                          return Container(
                            width: tableWidth,
                            padding: EdgeInsets.only(
                              top: rowTopBottomPadding,
                              bottom: rowTopBottomPadding,
                              left: 20,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen.withValues(alpha: .3),

                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...columnNamesList.map(
                                  (col) =>
                                      row[col] is Widget
                                          ? row[col]
                                          : Text(row[col]?.toString() ?? ''),
                                ),
                                if (hasActions)
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.all(8),
                                    child: actionBuilder!(row, index),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:ui';

// import 'package:flutter/material.dart';

// class TableWidget extends StatelessWidget {
//   final List<String> columnNamesList;
//   final List<Map<String, dynamic>> rowsValuesList;
//   final double cellHorizontalPadding;
//   final double cellVerticalPadding;
//   final double tableHeight;
//   final double tableWidth;
//   final Widget Function(Map<String, dynamic> rowData, int index)? actionBuilder;

//   const TableWidget({
//     super.key,
//     required this.columnNamesList,
//     required this.rowsValuesList,
//     this.cellHorizontalPadding = 8.0,
//     this.cellVerticalPadding = 8.0,
//     this.tableHeight = 300,
//     this.tableWidth = 300,
//     this.actionBuilder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hasActions = actionBuilder != null;
//     final verticalScrollController = ScrollController();
//     final horizontalScrollController = ScrollController();

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: ScrollConfiguration(
//         behavior: ScrollConfiguration.of(context).copyWith(
//           scrollbars: true,
//           dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
//         ),
//         child: Scrollbar(
//           thumbVisibility: true,
//           controller: verticalScrollController,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             controller: verticalScrollController,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: tableWidth),
//               child: SizedBox(
//                 height: tableHeight,
//                 width: tableWidth,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   controller: horizontalScrollController,
//                   child: DataTable(
//                     headingRowColor: WidgetStateProperty.all(
//                       Colors.green.shade100,
//                     ),
//                     border: TableBorder.all(color: Colors.grey.shade300),
//                     columns: [
//                       ...columnNamesList.map(
//                         (columnName) => DataColumn(label: Text(columnName)),
//                       ),
//                       if (hasActions) const DataColumn(label: Text('Actions')),
//                     ],
//                     rows: List.generate(rowsValuesList.length, (index) {
//                       final rowMap = rowsValuesList[index];

//                       return DataRow(
//                         cells: [
//                           ...columnNamesList.map((columnName) {
//                             final cellValue = rowMap[columnName];

//                             return DataCell(
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: cellHorizontalPadding,
//                                   vertical: cellVerticalPadding,
//                                 ),
//                                 child:
//                                     cellValue is Widget
//                                         ? cellValue
//                                         : Text(cellValue?.toString() ?? ''),
//                               ),
//                             );
//                           }),
//                           if (hasActions)
//                             DataCell(
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: cellHorizontalPadding,
//                                   vertical: cellVerticalPadding,
//                                 ),
//                                 child: actionBuilder!(rowMap, index),
//                               ),
//                             ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
