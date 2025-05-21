import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sws_crm_v5/models/user_model.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/view%20models/App%20Settings/app_settings_user_page_view_model.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/dialog_box_widget.dart';
import 'package:sws_crm_v5/widgets/dropdown_widget.dart';
import 'package:sws_crm_v5/widgets/stream_builder_widget.dart';
import 'package:sws_crm_v5/widgets/text_field_widget.dart';

class AppSettingsUserPage extends StatefulWidget {
  const AppSettingsUserPage({super.key});

  @override
  State<AppSettingsUserPage> createState() => _AppSettingsUserPageState();
}

class _AppSettingsUserPageState extends State<AppSettingsUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();

  String selectedRoleValue = 'Finance Manager';
  String selectedStatusValue = 'Active';
  int selectedMenuIndex = 0;
  List<Map<String, dynamic>> menusList = [
    {'icon': Icons.apps, 'title': 'All', 'value': 'All'},
    {
      'icon': Icons.attach_money,
      'title': 'Finance Managers',
      'value': 'Finance Manager',
    },
    {
      'icon': Icons.precision_manufacturing,
      'title': 'Production Managers',
      'value': 'Production Manager',
    },
    {
      'icon': Icons.admin_panel_settings,
      'title': 'Super Admins',
      'value': 'Super Admin',
    },
  ];
  final ScrollController _menuScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final AppSettingsUserPageViewModel viewModel =
        Provider.of<AppSettingsUserPageViewModel>(context, listen: false);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenusList(
                    menusList: menusList,
                    screenWidth: screenWidth,
                  ),
                  ButtonWidget(
                    title: 'Add',
                    isIconShown: true,
                    onTap: () {
                      DialogBoxWidget.show(
                        parentContext: context,
                        title: 'Add New User',
                        isBackOnSave: false,
                        dialogBoxHeight: 500,

                        content: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFieldWidget(
                                title: 'First Name',
                                controller: _firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'First Name is required';
                                  }

                                  return null;
                                },
                              ),
                              TextFieldWidget(
                                title: 'Last Name',
                                controller: _lastNameController,
                              ),
                              TextFieldWidget(
                                title: 'Email',
                                controller: _emailController,
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
                              DropdownWidget(
                                title: 'Role',
                                items: viewModel.roleValuesList,
                                value: selectedRoleValue,
                                onChanged: (String? newValue) {
                                  selectedRoleValue = newValue!;
                                  setState(() {});
                                },
                                itemLabelBuilder: (item) => item,
                              ),
                              TextFieldWidget(
                                title: 'Department',
                                controller: _departmentController,
                              ),
                              DropdownWidget(
                                title: 'Status',
                                items: viewModel.statusValuesList,
                                value: selectedStatusValue,
                                onChanged: (String? newValue) {
                                  selectedStatusValue = newValue!;
                                  setState(() {});
                                },
                                itemLabelBuilder: (item) => item,
                              ),
                            ],
                          ),
                        ),
                        onSave: (dialogBoxContext) async {
                          final viewModel =
                              Provider.of<AppSettingsUserPageViewModel>(
                                context,
                                listen: false,
                              );
                          if (_formKey.currentState!.validate()) {
                            await viewModel.createUser(
                              context: context,
                              dialogBoxContext: dialogBoxContext,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              role: selectedRoleValue,
                              department: _departmentController.text,
                              status: selectedStatusValue,
                            );
                          }
                        },
                      );
                    },
                    horizontalPadding: 20,
                    verticalPadding: 10,
                  ),
                ],
              ),
              _buildUsersTable(
                parentContext: context,
                screenHeight: screenHeight * 0.8,
                screenWidth: screenWidth,
                viewModel: viewModel,
              ),
            ],
          );
        },
      ),
    );
  }

  // Menu Items List
  Widget _buildMenusList({
    required List<Map<String, dynamic>> menusList,
    required double screenWidth,
  }) {
    return SizedBox(
      height: 50,
      width: screenWidth * 0.8,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: true,
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: Scrollbar(
          thumbVisibility: true,
          controller: _menuScrollController,
          child: ListView.builder(
            controller: _menuScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: menusList.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> menu = menusList[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedMenuIndex =
                            selectedMenuIndex == index ? 0 : index;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            selectedMenuIndex == index
                                ? AppColors.background
                                : AppColors.white,
                        border: Border.all(color: AppColors.greenBorder),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            menu['icon'],
                            color:
                                selectedMenuIndex == index
                                    ? AppColors.white
                                    : AppColors.darkGreenIcon,
                          ),
                          SizedBox(width: 10),
                          Text(
                            menu['title'],
                            style: TextStyle(
                              color:
                                  selectedMenuIndex == index
                                      ? AppColors.white
                                      : AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Users table
  Widget _buildUsersTable({
    required BuildContext parentContext,
    required double screenHeight,
    required double screenWidth,
    required AppSettingsUserPageViewModel viewModel,
  }) => StreamBuilderWidget<List<UserModel>>(
    stream: viewModel.fetchUsersList(
      context: parentContext,
      roleFilter: menusList[selectedMenuIndex]['value'],
    ),
    builder: (context, usersList) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screenWidth,
          maxHeight: screenHeight,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 16,
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
            columns: const [
              // DataColumn(label: Text('Picture')),
              DataColumn(label: Text('Full Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Secondary Role')),
              DataColumn(label: Text('Vendors')),
              DataColumn(label: Text('Troubleshooting')),
              DataColumn(label: Text('Status')),
            ],
            rows:
                usersList.map((user) {
                  return DataRow(
                    cells: [
                      // DataCell(
                      //   CircleAvatar(
                      //     backgroundImage: NetworkImage('N/A'),
                      //     radius: 16,
                      //   ),
                      // ),
                      DataCell(Text('${user.firstName} ${user.lastName}')),
                      DataCell(Text(user.email)),
                      DataCell(Text(user.phone)),
                      DataCell(Text(user.role)),
                      DataCell(Text(user.secondaryRole)),
                      DataCell(
                        Text(
                          user.vendors.isEmpty
                              ? 'N/A'
                              : user.vendors.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          user.troubleShooting.isEmpty
                              ? 'N/A'
                              : user.troubleShooting.toString(),
                        ),
                      ),
                      DataCell(
                        Chip(
                          label: Text(user.status),
                          backgroundColor:
                              user.status == 'Active'
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                          labelStyle: TextStyle(
                            color:
                                user.status == 'Active'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      );
    },
  );
}
