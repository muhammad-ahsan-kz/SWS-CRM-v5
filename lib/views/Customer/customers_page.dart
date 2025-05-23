import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sws_crm_v5/models/add_customer_model.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';
import 'package:sws_crm_v5/view%20models/Customer/customers_page_view_model.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/dialog_box_widget.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';
import 'package:sws_crm_v5/widgets/loading_animation_widget.dart';
import 'package:sws_crm_v5/widgets/new_button.dart';
import 'package:sws_crm_v5/widgets/stream_builder_widget.dart';
import 'package:sws_crm_v5/widgets/table_widget.dart';
import 'package:sws_crm_v5/widgets/text_field_widget.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final _formKey = GlobalKey<FormState>();
  // Customers table columns
  final List<String> columnNamesList = [
    "Customer ID",
    "Full Name",
    "Phone",
    "Mobile",
    "Email",
    "Address",
  ];

  // final rowsValuesList =
  //     CustomersListModel.customerList.map((c) => c.toJson()).toList();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CustomersPageViewModel>(
      context,
      listen: false,
    );

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
                  IconButtonWidget(
                    icon: Icons.upload_file_outlined,
                    padding: 5,
                    ontap:
                        () => DialogBoxWidget.show(
                          parentContext: context,
                          title: 'Import File',
                          content: Column(children: []),
                          onSave: (dialogBoxContext) {},
                        ),
                  ),
                  IconButtonWidget(
                    icon: Icons.download_outlined,
                    padding: 5,
                    ontap:
                        () => DialogBoxWidget.show(
                          parentContext: context,
                          title: 'Download File',
                          content: Column(children: []),
                          onSave: (dialogBoxContext) {},
                        ),
                  ),
                  NewButton(
                    title: 'Add Customer',
                    icon: Icons.add,
                    ontap: () {
                      // Dialog Box
                      addNewCustomerDialogBox(
                        context: context,
                        viewModel: viewModel,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // if ((rowsValuesList.isEmpty))
          //   TableWidget(
          //     columnNamesList: ['Name'],
          //     rowsValuesList: rowsValuesList,
          //     columnSizes: [],
          //     tableWidth: screenWidth * 0.8,
          //     tableHeight: screenHeight * 0.7,
          //   )
          // else
          //   Expanded(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         TableWidget(
          //           columnNamesList: columnNamesList,
          //           rowsValuesList: rowsValuesList,
          //           columnSizes: [
          //             screenWidth * 0.05,
          //             screenWidth * 0.08,
          //             screenWidth * 0.05,
          //             screenWidth * 0.05,
          //             screenWidth * 0.11,
          //             screenWidth * 0.18,
          //           ],
          //           tableWidth: screenWidth * 0.8,
          //           tableHeight: screenHeight * 0.7,
          //           rowTopBottomPadding: 7,
          //           onRowTap: (rowData) {
          //             // final customerDetails = CustomersListModel.fromMap(
          //             //   rowData,
          //             // );
          //             context.goNamed(
          //               RouteNames.customerDashboardPage,
          //               // extra: customerDetails,
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          _buildShowCustomersListTable(
            viewModel: viewModel,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  // Add new customer dialog box
  Future<void> addNewCustomerDialogBox({
    required BuildContext context,
    required CustomersPageViewModel viewModel,
  }) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController secondaryNameController =
        TextEditingController();
    final TextEditingController secondaryLastNameController =
        TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController unitController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return DialogBoxWidget.show(
      parentContext: context,
      title: 'Add New Customer',
      isBackOnSave: false,
      dialogBoxHeight: 500,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    title: 'First Name',
                    controller: firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First Name is required';
                      }

                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFieldWidget(
                    title: 'Last Name',
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    title: 'Secondary Name',
                    controller: secondaryNameController,
                  ),
                ),
                Expanded(
                  child: TextFieldWidget(
                    title: 'Secondary Last Name',
                    controller: secondaryLastNameController,
                  ),
                ),
              ],
            ),

            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    title: 'Phone',
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFieldWidget(
                    title: 'Mobile',
                    controller: mobileController,
                  ),
                ),
              ],
            ),
            TextFieldWidget(title: 'Address', controller: addressController),
            TextFieldWidget(title: 'Unit Name', controller: unitController),
            TextFieldWidget(
              title: 'Email',
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }

                if (!RegExp(
                  r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }

                return null;
              },
            ),
          ],
        ),
      ),
      onSave: (dialogBoxContext) async {
        final customerDetails = AddCustomerModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          secondaryName: secondaryNameController.text,
          secondaryLastName: secondaryLastNameController.text,
          phone: phoneController.text,
          mobile: mobileController.text,
          address: addressController.text,
          unit: unitController.text,
          email: emailController.text,
        );

        if (_formKey.currentState!.validate()) {
          await viewModel.addCustomer(
            parentContext: context,
            dialogBoxContext: dialogBoxContext,
            customerDetails: customerDetails.toJson(),
          );
        }
      },
    );
  }

  // // Edit customer dialog box
  Future<void> editCustomerDialogBox({
    required BuildContext context,
    required CustomersPageViewModel viewModel,
    required String customerId,
    required String firstName,
    required String lastName,
    required String secondaryName,
    required String secondaryLastName,
    required String phone,
    required String mobile,
    required String address,
    required String unit,
    required String email,
  }) {
    final TextEditingController firstNameController = TextEditingController(
      text: firstName,
    );
    final TextEditingController lastNameController = TextEditingController(
      text: lastName,
    );
    final TextEditingController secondaryNameController = TextEditingController(
      text: secondaryName,
    );
    final TextEditingController secondaryLastNameController =
        TextEditingController(text: secondaryLastName);
    final TextEditingController phoneController = TextEditingController(
      text: phone,
    );
    final TextEditingController mobileController = TextEditingController(
      text: mobile,
    );
    final TextEditingController addressController = TextEditingController(
      text: address,
    );
    final TextEditingController unitController = TextEditingController(
      text: unit,
    );
    final TextEditingController emailController = TextEditingController(
      text: email,
    );

    return DialogBoxWidget.show(
      parentContext: context,
      title: 'Edit Customer',
      saveButtonText: 'Update',
      isBackOnSave: false,
      dialogBoxHeight: 500,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    title: 'First Name',
                    controller: firstNameController,
                    // initialValue: 'Ahsan',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First Name is required';
                      }

                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFieldWidget(
                    title: 'Last Name',
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    title: 'Secondary Name',
                    controller: secondaryNameController,
                  ),
                ),
                Expanded(
                  child: TextFieldWidget(
                    title: 'Secondary Last Name',
                    controller: secondaryLastNameController,
                  ),
                ),
              ],
            ),

            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: TextFieldWidget(
                    title: 'Phone',
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFieldWidget(
                    title: 'Mobile',
                    controller: mobileController,
                  ),
                ),
              ],
            ),
            TextFieldWidget(title: 'Address', controller: addressController),
            TextFieldWidget(title: 'Unit Name', controller: unitController),
            TextFieldWidget(
              title: 'Email',
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }

                if (!RegExp(
                  r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }

                return null;
              },
            ),
          ],
        ),
      ),
      onSave: (dialogBoxContext) async {
        final customerDetails = AddCustomerModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          secondaryName: secondaryNameController.text,
          secondaryLastName: secondaryLastNameController.text,
          phone: phoneController.text,
          mobile: mobileController.text,
          address: addressController.text,
          unit: unitController.text,
          email: emailController.text,
        );

        if (_formKey.currentState!.validate()) {
          await viewModel.editCustomer(
            parentContext: context,
            dialogBoxContext: dialogBoxContext,
            customerId: customerId,
            customerDetails: customerDetails.toJson(),
          );
        }
      },
    );
  }

  // Delete customer dialog box
  Future<void> deleteCustomerDialogBox({
    required BuildContext context,
    required CustomersPageViewModel viewModel,
    required String customerId,
  }) {
    return DialogBoxWidget.show(
      parentContext: context,
      title: 'Delete Customer',
      saveButtonText: 'Delete',
      isBackOnSave: false,
      dialogBoxHeight: 200,
      content: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Are you sure you want to delete this customer?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: AppColors.lightGreenText),
          ),
        ],
      ),
      onSave: (dialogBoxContext) async {
        await viewModel.deleteCustomer(
          parentContext: context,
          dialogBoxContext: dialogBoxContext,
          customerId: customerId,
        );
      },
    );
  }

  // Customers List Table
  Widget _buildShowCustomersListTable({
    required CustomersPageViewModel viewModel,
    required double screenWidth,
    required double screenHeight,
  }) {
    return StreamBuilderWidget<List<Map<String, dynamic>>>(
      stream: viewModel.fetchCustomersList(parentContext: context),
      builder: (context, rowsValuesList) {
        if ((rowsValuesList.isEmpty)) {
          return TableWidget(
            columnNamesList: ['Name'],
            rowValuesList: rowsValuesList,
            columnSizes: [],
            tableWidth: screenWidth * 0.8,
            tableHeight: screenHeight * 0.7,
            emptyTableMessage: 'No Customers Found !',
          );
        } else {
          return Table(
            border: TableBorder.all(color: Colors.grey.shade400, width: 1),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
              6: FlexColumnWidth(),
              7: FlexColumnWidth(),
            },
            children: [
              // Table Header
              TableRow(
                // decoration: BoxDecoration(color: Colors.grey.shade200),
                children: [
                  _buildTableColumnText(title: 'Customer ID'),
                  _buildTableColumnText(title: 'Full Name'),
                  _buildTableColumnText(title: 'Phone'),
                  _buildTableColumnText(title: 'Mobile'),
                  _buildTableColumnText(title: 'Email'),
                  _buildTableColumnText(title: 'Address'),
                  _buildTableColumnText(title: 'Actions'),
                ],
              ),
              // Table Rows
              ...rowsValuesList.map((customer) {
                return TableRow(
                  children: [
                    _buildTableRowText(
                      title: customer['id'],
                      customerId: customer['id'],
                    ),
                    _buildTableRowText(
                      title: '${customer['fullName']}',
                      customerId: customer['id'],
                    ),
                    _buildTableRowText(
                      title: customer['phone'],
                      customerId: customer['id'],
                    ),
                    _buildTableRowText(
                      title: customer['mobile'],
                      customerId: customer['id'],
                    ),
                    _buildTableRowText(
                      title: customer['email'],
                      customerId: customer['id'],
                    ),
                    _buildTableRowText(
                      title: customer['address'],
                      customerId: customer['id'],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButtonWidget(
                          icon: Icons.edit_outlined,
                          padding: 5,
                          ontap: () {
                            // Dialog Box
                            editCustomerDialogBox(
                              context: context,
                              viewModel: viewModel,
                              customerId: customer['id'],
                              firstName: customer['firstName'],
                              lastName: customer['lastName'],
                              secondaryName: customer['secondaryName'],
                              secondaryLastName: customer['secondaryLastName'],
                              phone: customer['phone'],
                              mobile: customer['mobile'],
                              email: customer['email'],
                              address: customer['address'],
                              unit: customer['unit'],
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        IconButtonWidget(
                          icon: Icons.delete_outline,
                          padding: 5,
                          ontap: () {
                            // Dialog Box
                            deleteCustomerDialogBox(
                              context: context,
                              viewModel: viewModel,
                              customerId: customer['id'],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ],
          );
          // return Expanded(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       TableWidget(
          //         columnNamesList: columnNamesList,
          //         rowValuesList: rowsValuesList,
          //         columnSizes: [
          //           screenWidth * 0.07,
          //           screenWidth * 0.08,
          //           screenWidth * 0.05,
          //           screenWidth * 0.05,
          //           screenWidth * 0.11,
          //           screenWidth * 0.18,
          //         ],
          //         tableWidth: screenWidth * 0.8,
          //         tableHeight: screenHeight * 0.7,
          //         rowTopBottomPadding: 7,
          //         onRowTap: (rowData) {
          //           final String customerId = rowData['id'] ?? 'Unknown';
          //           context.goNamed(
          //             RouteNames.customerDashboardPage,
          //             queryParameters: {'customerId': customerId},
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // );
        }
      },
      loadingWidget: LoadingAnimationWidget(),
    );
  } // Column Text

  Widget _buildTableColumnText({required title}) => Padding(
    padding: EdgeInsets.all(10),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColors.lightGreenText, fontSize: 15),
    ),
  );

  // Row Text
  Widget _buildTableRowText({required title, required String customerId}) =>
      InkWell(
        hoverColor: Colors.transparent, // No color on hover
        splashColor: Colors.transparent, // No splash on click
        highlightColor: Colors.transparent, // No highlight on tap down
        mouseCursor: SystemMouseCursors.click, // Change to hand cursor
        onTap: () {
          context.goNamed(
            RouteNames.customerDashboardPage,
            queryParameters: {'customerId': customerId},
          );
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
        ),
      );
}
