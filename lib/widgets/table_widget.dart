import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class TableWidget extends StatelessWidget {
  final List<String> columnNamesList;
  final List<Map<String, dynamic>> rowValuesList;
  final List<double> columnSizes;
  final double cellHorizontalPadding;
  final double cellVerticalPadding;
  final double tableHeight;
  final double tableWidth;
  final double rowTopBottomPadding;
  final MainAxisAlignment mainAxisAlignment;
  final String emptyTableMessage;
  final void Function(Map<String, dynamic> rowData)? onRowTap;
  final Widget Function(Map<String, dynamic> rowData, int index)? actionBuilder;

  const TableWidget({
    super.key,
    required this.columnNamesList,
    required this.rowValuesList,
    required this.columnSizes,
    this.cellHorizontalPadding = 8.0,
    this.cellVerticalPadding = 8.0,
    this.tableHeight = 500,
    this.tableWidth = 600,
    this.rowTopBottomPadding = 5,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.emptyTableMessage = 'No Items Available !',
    this.onRowTap,
    this.actionBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final hasActions = actionBuilder != null;
    final horizontalScrollController = ScrollController();
    final rowFieldKeys =
        rowValuesList.isNotEmpty
            ? rowValuesList.first.keys.toList()
            : <String>[];

    return Container(
      // width: tableWidth,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greenBorder),
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
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: !hasActions ? 20 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,

                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.greenBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: mainAxisAlignment,
                    spacing: 15,
                    children: [
                      ...columnNamesList.asMap().entries.map((entry) {
                        final i = entry.key;
                        final col = entry.value;
                        final double width =
                            (i < columnSizes.length) ? columnSizes[i] : 100;
                        return SizedBox(
                          width: width,
                          child: Text(
                            col,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreenText,
                            ),
                          ),
                        );
                      }),
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
                (rowValuesList.isEmpty ||
                        columnNamesList.length != columnSizes.length)
                    ? SizedBox(
                      height: tableHeight,
                      width: tableWidth,
                      child: Center(
                        child: Text(
                          emptyTableMessage,
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
                        padding: EdgeInsets.zero,
                        itemCount: rowValuesList.length,
                        itemBuilder: (context, index) {
                          final row = rowValuesList[index];
                          return InkWell(
                            onTap:
                                onRowTap == null ? null : () => onRowTap!(row),
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: tableWidth,
                              padding: EdgeInsets.only(
                                top: rowTopBottomPadding,
                                bottom: rowTopBottomPadding,
                                left: 20,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lightGreen.withValues(
                                  alpha: .3,
                                ),

                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                spacing: 15,
                                mainAxisAlignment: mainAxisAlignment,
                                children: [
                                  ...rowFieldKeys.asMap().entries.map((entry) {
                                    final i = entry.key;
                                    final col = rowFieldKeys[i];
                                    final value = row[col];
                                    final double width =
                                        (i < columnSizes.length)
                                            ? columnSizes[i]
                                            : 100;
                                    return row[col] is Widget
                                        ? row[col]
                                        : SizedBox(
                                          width: width,
                                          child: Text(
                                            value == null || value == ''
                                                ? 'N/A'
                                                : value.toString(),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                  }),
                                  if (hasActions)
                                    Container(
                                      width: 100,
                                      padding: EdgeInsets.all(8),
                                      child: actionBuilder!(row, index),
                                    ),
                                ],
                              ),
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
// import 'package:sws_crm_v5/utils/app_colors.dart';

// class TableWidget extends StatelessWidget {
//   final List<String> columnNamesList;
//   final List<Map<String, dynamic>> rowsValuesList;
//   final List<double> columnSizes;
//   final double cellHorizontalPadding;
//   final double cellVerticalPadding;
//   final double tableHeight;
//   final double tableWidth;
//   final double rowTopBottomPadding;
//   final MainAxisAlignment mainAxisAlignment;
//   final void Function(Map<String, dynamic> rowData)? onRowTap;
//   final Widget Function(Map<String, dynamic> rowData, int index)? actionBuilder;

//   const TableWidget({
//     super.key,
//     required this.columnNamesList,
//     required this.rowsValuesList,
//     required this.columnSizes,
//     this.cellHorizontalPadding = 8.0,
//     this.cellVerticalPadding = 8.0,
//     this.tableHeight = 500,
//     this.tableWidth = 600,
//     this.rowTopBottomPadding = 5,
//     this.mainAxisAlignment = MainAxisAlignment.start,
//     this.onRowTap,
//     this.actionBuilder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hasActions = actionBuilder != null;
//     final horizontalScrollController = ScrollController();

//     return Container(
//       // width: tableWidth,
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.greenBorder),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ScrollConfiguration(
//         behavior: ScrollConfiguration.of(context).copyWith(
//           scrollbars: true,
//           dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
//         ),
//         child: Scrollbar(
//           thumbVisibility: true,
//           controller: horizontalScrollController,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             controller: horizontalScrollController,
//             child: Column(
//               children: [
//                 // Table Header
//                 Container(
//                   width: tableWidth,
//                   padding: EdgeInsets.only(
//                     top: 10,
//                     bottom: 10,
//                     left: 20,
//                     right: !hasActions ? 20 : 0,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,

//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(color: AppColors.greenBorder),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: mainAxisAlignment,
//                     spacing: 15,
//                     children: [
//                       ...columnNamesList.asMap().entries.map((entry) {
//                         final i = entry.key;
//                         final col = entry.value;
//                         return SizedBox(
//                           width: columnSizes[i],
//                           child: Text(
//                             col,
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.darkGreenText,
//                             ),
//                           ),
//                         );
//                       }),
//                       if (hasActions)
//                         SizedBox(
//                           width: 100,
//                           child: Text(
//                             "Actions",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.darkGreenText,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // Scrollable Table Rows
//                 rowsValuesList.isEmpty
//                     ? SizedBox(
//                       height: tableHeight,
//                       width: tableWidth,
//                       child: Center(
//                         child: Text(
//                           'No Items Available !',
//                           style: TextStyle(color: AppColors.darkGreenText),
//                         ),
//                       ),
//                     )
//                     : SizedBox(
//                       height: tableHeight,
//                       width: tableWidth,
//                       child: ListView.separated(
//                         separatorBuilder:
//                             (context, index) => SizedBox(height: 10),
//                         padding: EdgeInsets.zero,
//                         itemCount: rowsValuesList.length,
//                         itemBuilder: (context, index) {
//                           final row = rowsValuesList[index];
//                           return InkWell(
//                             onTap:
//                                 onRowTap == null ? null : () => onRowTap!(row),
//                             borderRadius: BorderRadius.circular(50),
//                             child: Container(
//                               width: tableWidth,
//                               padding: EdgeInsets.only(
//                                 top: rowTopBottomPadding,
//                                 bottom: rowTopBottomPadding,
//                                 left: 20,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppColors.lightGreen.withValues(
//                                   alpha: .3,
//                                 ),

//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               child: Row(
//                                 spacing: 15,
//                                 mainAxisAlignment: mainAxisAlignment,
//                                 children: [
//                                   ...columnNamesList.asMap().entries.map((
//                                     entry,
//                                   ) {
//                                     final i = entry.key;
//                                     final col = entry.value;
//                                     return row[col] is Widget
//                                         ? row[col]
//                                         : SizedBox(
//                                           width: columnSizes[i],
//                                           child: Text(
//                                             row[col] == ''
//                                                 ? 'N/A'
//                                                 : row[col]?.toString() ?? '',
//                                             textAlign: TextAlign.start,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         );
//                                   }),
//                                   if (hasActions)
//                                     Container(
//                                       width: 100,
//                                       padding: EdgeInsets.all(8),
//                                       child: actionBuilder!(row, index),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
