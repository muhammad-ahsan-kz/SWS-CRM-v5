import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/models/customers_list_model.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';
import 'package:sws_crm_v5/widgets/table_widget.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  // Customers table columns
  final List<String> columnNamesList = [
    "Customer ID",
    "Full Name",
    "Phone",
    "Mobile",
    "Email",
    "Address",
  ];

  final rowsValuesList =
      CustomersListModel.customerList.map((c) => c.toMap()).toList();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Customers',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  IconButtonWidget(icon: Icons.add_circle_outline, padding: 5),
                  IconButtonWidget(
                    icon: Icons.insert_drive_file_outlined,
                    padding: 5,
                  ),
                  ButtonWidget(
                    title: 'Download',
                    icon: Icons.insert_drive_file_outlined,
                    onTap: () {
                      // showCustomDialog(
                      //   context: context,
                      //   subMenuName: 'Download',
                      // );
                    },
                    isIconShown: true,
                    textSize: 15,
                    iconSize: 18,
                    horizontalPadding: 20,
                    verticalPadding: 8,
                  ),
                  IconButtonWidget(icon: Icons.filter_list, padding: 5),
                  IconButtonWidget(icon: Icons.done_all, padding: 5),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          if ((rowsValuesList.isEmpty))
            TableWidget(
              columnNamesList: ['Name'],
              rowsValuesList: rowsValuesList,
              columnSizes: [],
              tableWidth: screenWidth * 0.8,
              tableHeight: screenHeight * 0.7,
            )
          else
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableWidget(
                    columnNamesList: columnNamesList,
                    rowsValuesList: rowsValuesList,
                    columnSizes: [
                      screenWidth * 0.05,
                      screenWidth * 0.08,
                      screenWidth * 0.05,
                      screenWidth * 0.05,
                      screenWidth * 0.11,
                      screenWidth * 0.18,
                    ],
                    tableWidth: screenWidth * 0.8,
                    tableHeight: screenHeight * 0.7,
                    rowTopBottomPadding: 7,
                    onRowTap: (rowData) {
                      final customerDetails = CustomersListModel.fromMap(
                        rowData,
                      );
                      context.goNamed(
                        RouteNames.customerDashboardPage,
                        // extra: customerDetails,
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Dialog Box
  void showCustomDialog({
    required BuildContext context,
    required String subMenuName,
  }) {
    final TextEditingController field1Controller = TextEditingController();
    final TextEditingController field2Controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            subMenuName,
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLabeledTextField('Type', field1Controller),
                SizedBox(height: 10),
                _buildLabeledTextField('Color', field2Controller),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryGreen),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle save logic here
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreenIcon,
                foregroundColor: Colors.white,
              ),
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Text Field
  Widget _buildLabeledTextField(
    String label,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryGreen,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
