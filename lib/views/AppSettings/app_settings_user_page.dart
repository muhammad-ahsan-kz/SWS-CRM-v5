import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sws_crm_v5/models/user_model.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';
import 'package:sws_crm_v5/view%20models/App%20Settings/app_settings_user_page_view_model.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/dialog_box_widget.dart';
import 'package:sws_crm_v5/widgets/dropdown_widget.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';
import 'package:sws_crm_v5/widgets/loading_animation_widget.dart';
import 'package:sws_crm_v5/widgets/new_button.dart';
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
                  Text(
                    'Users',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  Row(
                    children: [
                      NewButton(
                        title: 'Filter',
                        ontap: () {},
                        icon: Icons.filter_list,
                      ),
                      NewButton(
                        title: 'Add User',
                        icon: Icons.add,
                        ontap: () {
                          addUserDialogBox(viewModel: viewModel);
                        },
                      ),

                      // ButtonWidget(
                      //   title: 'Add User',
                      //   isIconShown: true,
                      //   onTap: () {},
                      //   horizontalPadding: 20,
                      //   verticalPadding: 10,
                      // ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenusList(
                    menusList: menusList,
                    screenWidth: screenWidth,
                  ),
                ],
              ),
              SizedBox(height: 10),
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
          child: Table(
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
                  _buildTableColumnText(title: 'Full Name'),
                  _buildTableColumnText(title: 'Email'),
                  _buildTableColumnText(title: 'Phone'),
                  _buildTableColumnText(title: 'Role'),
                  _buildTableColumnText(title: 'Secondary Role'),
                  _buildTableColumnText(title: 'Vendors'),
                  _buildTableColumnText(title: 'Trouble Shooting'),
                  _buildTableColumnText(title: 'Status'),
                  _buildTableColumnText(title: 'Actions'),
                ],
              ),
              // Table Rows
              ...usersList.map((user) {
                return TableRow(
                  children: [
                    _buildTableRowText(
                      title: '${user.firstName} ${user.lastName}',
                      userId: '',
                    ),
                    _buildTableRowText(title: user.email, userId: ''),
                    _buildTableRowText(title: user.phone, userId: ''),
                    _buildTableRowText(title: user.role, userId: ''),
                    _buildTableRowText(title: user.secondaryRole, userId: ''),
                    _buildTableRowText(
                      title:
                          user.vendors.isEmpty ? '' : user.vendors.toString(),
                      userId: '',
                    ),
                    _buildTableRowText(
                      title:
                          user.troubleShooting.isEmpty
                              ? ''
                              : user.troubleShooting.toString(),
                      userId: '',
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            user.status == 'Active'
                                ? AppColors.lightGreen.withValues(alpha: .3)
                                : AppColors.red.withValues(alpha: .3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.status,
                            style: TextStyle(
                              color:
                                  user.status == 'Active'
                                      ? AppColors.darkGreenText
                                      : AppColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        IconButtonWidget(
                          ontap: () {
                            editUserDialogBox(
                              context: context,
                              viewModel: viewModel,
                              userId: user.id,
                              firstName: user.firstName,
                              lastName: user.lastName,
                              phone: user.phone,
                              email: user.email,
                              role: user.role,
                              department: user.department,
                              status: user.status,
                              secondaryRole: user.secondaryRole,
                              vendors: user.vendors,
                              troubleShooting: user.troubleShooting,
                            );
                          },
                          icon: Icons.edit_outlined,
                          size: 20,
                          padding: 5,
                        ),
                        IconButtonWidget(
                          ontap: () {
                            deleteUserDialogBox(
                              context: context,
                              viewModel: viewModel,
                              userId: user.id,
                            );
                          },
                          icon: Icons.delete_outline,
                          size: 20,
                          padding: 5,
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      );
    },
    loadingWidget: LoadingAnimationWidget(),
  );

  // Column Text
  Widget _buildTableColumnText({required title}) => Padding(
    padding: EdgeInsets.all(10),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(color: AppColors.lightGreenText, fontSize: 15),
    ),
  );

  // Row Text
  Widget _buildTableRowText({required title, required String userId}) =>
      GestureDetector(
        onTap: () {
          // context.goNamed(
          //   RouteNames.customerDashboardPage,
          //   queryParameters: {'userId': userId},
          // );
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

  // Edit user dialog box
  Future<void> addUserDialogBox({
    // required BuildContext context,
    required AppSettingsUserPageViewModel viewModel,
    // required String userId,
  }) {
    return DialogBoxWidget.show(
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
              value: viewModel.selectedRoleValue,
              onChanged: (String? newValue) {
                viewModel.selectedRoleValue = newValue!;
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
              value: viewModel.selectedStatusValue,
              onChanged: (String? newValue) {
                viewModel.selectedStatusValue = newValue!;
                setState(() {});
              },
              itemLabelBuilder: (item) => item,
            ),
          ],
        ),
      ),
      onSave: (dialogBoxContext) async {
        final viewModel = Provider.of<AppSettingsUserPageViewModel>(
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
            role: viewModel.selectedRoleValue,
            department: _departmentController.text,
            status: viewModel.selectedStatusValue,
          );
        }
      },
    );
  }

  // Edit user dialog box
  Future<void> editUserDialogBox({
    required BuildContext context,
    required AppSettingsUserPageViewModel viewModel,
    required String userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String role,
    required String department,
    required String status,
    required String secondaryRole,
    required List<String> vendors,
    required List<String> troubleShooting,
  }) {
    final TextEditingController firstNameController = TextEditingController(
      text: firstName,
    );
    final TextEditingController lastNameController = TextEditingController(
      text: lastName,
    );
    final TextEditingController emailController = TextEditingController(
      text: email,
    );
    final TextEditingController departmentController = TextEditingController(
      text: department,
    );
    viewModel.selectedRoleValue = role;
    viewModel.selectedStatusValue = status;
    return DialogBoxWidget.show(
      parentContext: context,
      title: 'Edit User',
      saveButtonText: 'Update',
      isBackOnSave: false,
      dialogBoxHeight: 500,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFieldWidget(
              title: 'First Name',
              controller: firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First Name is required';
                }

                return null;
              },
            ),
            TextFieldWidget(title: 'Last Name', controller: lastNameController),
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
            DropdownWidget(
              title: 'Role',
              items: viewModel.roleValuesList,
              value: viewModel.selectedRoleValue,
              onChanged: (String? newValue) {
                viewModel.selectedRoleValue = newValue!;
                setState(() {});
              },
              itemLabelBuilder: (item) => item,
            ),
            TextFieldWidget(
              title: 'Department',
              controller: departmentController,
            ),
            DropdownWidget(
              title: 'Status',
              items: viewModel.statusValuesList,
              value: viewModel.selectedStatusValue,
              onChanged: (String? newValue) {
                viewModel.selectedStatusValue = newValue!;
                setState(() {});
              },
              itemLabelBuilder: (item) => item,
            ),
          ],
        ),
      ),
      onSave: (dialogBoxContext) async {
        final userDetails = UserModel(
          id: userId,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phone: phone,
          email: emailController.text,
          role: viewModel.selectedRoleValue,
          department: departmentController.text,
          status: viewModel.selectedStatusValue,
          secondaryRole: secondaryRole,
          vendors: vendors,
          troubleShooting: troubleShooting,
        );

        if (_formKey.currentState!.validate()) {
          await viewModel.editUser(
            parentContext: context,
            dialogBoxContext: dialogBoxContext,
            userId: userId,
            userDetails: userDetails.toJson(),
          );
        }
      },
    );
  }

  // Delete user dialog box
  Future<void> deleteUserDialogBox({
    required BuildContext context,
    required AppSettingsUserPageViewModel viewModel,
    required String userId,
  }) {
    return DialogBoxWidget.show(
      parentContext: context,
      title: 'Delete User',
      saveButtonText: 'Delete',
      isBackOnSave: false,
      dialogBoxHeight: 200,
      content: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Are you sure you want to delete this user?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: AppColors.lightGreenText),
          ),
        ],
      ),
      onSave: (dialogBoxContext) async {
        await viewModel.deleteUser(
          parentContext: context,
          dialogBoxContext: dialogBoxContext,
          userId: userId,
        );
      },
    );
  }
}









// DataTable(
//             columnSpacing: 16,
//             headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
//             columns: const [
//               DataColumn(label: Text('Full Name')),
//               DataColumn(label: Text('Email')),
//               DataColumn(label: Text('Phone')),
//               DataColumn(label: Text('Role')),
//               DataColumn(label: Text('Secondary Role')),
//               DataColumn(label: Text('Vendors')),
//               DataColumn(label: Text('Troubleshooting')),
//               DataColumn(label: Text('Status')),
//             ],
//             rows:
//                 usersList.map((user) {
//                   return DataRow(
//                     cells: [
//                       DataCell(Text('${user.firstName} ${user.lastName}')),
//                       DataCell(Text(user.email)),
//                       DataCell(Text(user.phone)),
//                       DataCell(Text(user.role)),
//                       DataCell(Text(user.secondaryRole)),
//                       DataCell(
//                         Text(
//                           user.vendors.isEmpty
//                               ? 'N/A'
//                               : user.vendors.toString(),
//                         ),
//                       ),
//                       DataCell(
//                         Text(
//                           user.troubleShooting.isEmpty
//                               ? 'N/A'
//                               : user.troubleShooting.toString(),
//                         ),
//                       ),
//                       DataCell(
//                         Chip(
//                           label: Text(user.status),
//                           backgroundColor:
//                               user.status == 'Active'
//                                   ? Colors.green.shade100
//                                   : Colors.red.shade100,
//                           labelStyle: TextStyle(
//                             color:
//                                 user.status == 'Active'
//                                     ? Colors.green
//                                     : Colors.red,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//           ),