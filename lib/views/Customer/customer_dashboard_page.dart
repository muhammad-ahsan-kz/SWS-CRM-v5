import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sws_crm_v5/models/project_model.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';
import 'package:sws_crm_v5/view%20models/Customer/customer_dashboard_page_view_model.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/dialog_box_widget.dart';
import 'package:sws_crm_v5/widgets/dropdown_widget.dart';
import 'package:sws_crm_v5/widgets/future_builder_widget.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';
import 'package:sws_crm_v5/widgets/loading_animation_widget.dart';
import 'package:sws_crm_v5/widgets/stream_builder_widget.dart';
import 'package:sws_crm_v5/widgets/text_field_widget.dart';

import '../../utils/app_colors.dart';

class CustomerDashboardPage extends StatefulWidget {
  final String customerId;
  const CustomerDashboardPage({super.key, required this.customerId});

  @override
  State<CustomerDashboardPage> createState() => _CustomerDashboardPageState();
}

class _CustomerDashboardPageState extends State<CustomerDashboardPage> {
  final _pageOneFormKey = GlobalKey<FormState>();
  final _pageTwoFormKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CustomerDashboardPageViewModel>(
      context,
      listen: false,
    );
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomerHeader(
                parentContext: context,
                pageController: pageController,
                currentPage: currentPage,
                viewModel: viewModel,
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomerDetails(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    viewModel: viewModel,
                  ),
                  _buildCustomerProjects(
                    context: context,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    viewModel: viewModel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Customer Dashboard Header
  Widget _buildCustomerHeader({
    required BuildContext parentContext,
    required PageController pageController,
    required int currentPage,
    required CustomerDashboardPageViewModel viewModel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Dashboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),
            FutureBuilderWidget(
              future: viewModel.fetchCustomerDetails(
                customerId: widget.customerId,
              ),
              builder: (context, snapshot) {
                return Text(
                  'Welcome back ${snapshot!['firstName']} ${snapshot['lastName']}',
                  style: TextStyle(fontSize: 12, color: AppColors.lightGreen),
                );
              },
              loadingWidget: Text(
                '...',
                style: TextStyle(fontSize: 12, color: AppColors.lightGreen),
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            IconButtonWidget(
              icon: Icons.add_circle_outline,
              padding: 5,
              ontap: () {
                // Dialog Box
                addNewProjectDialogBox(
                  parentContext: parentContext,
                  viewModel: viewModel,
                  pageController: pageController,
                  currentPage: currentPage,
                );
              },
            ),
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
    );
  }

  // Customer Dashboard Details Box
  Widget _buildCustomerDetails({
    required double screenHeight,
    required double screenWidth,
    required CustomerDashboardPageViewModel viewModel,
  }) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: Container(
        height: screenHeight * 0.7,
        width: screenWidth * 0.15,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.greyBorder),
          // borderRadius: BorderRadius.circular(15),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer details',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            FutureBuilderWidget(
              future: viewModel.fetchCustomerDetails(
                customerId: widget.customerId,
              ),
              builder: (context, snapshot) {
                return SizedBox(
                  height: screenHeight * 0.2,
                  child: Column(
                    children: [
                      _buildDetailsRow(
                        title: 'Customer Id',
                        value: widget.customerId,
                      ),
                      _buildDetailsRow(
                        title: 'Full Name',
                        value:
                            '${snapshot!['firstName']} ${snapshot['lastName']}',
                      ),
                      _buildDetailsRow(
                        title: 'Address',
                        value: snapshot['address'],
                      ),
                      _buildDetailsRow(
                        title: 'Phone',
                        value: snapshot['phone'],
                      ),
                      _buildDetailsRow(
                        title: 'Email',
                        value: snapshot['email'],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                );
              },
              loadingWidget: SizedBox(
                height: screenHeight * 0.2,
                child: LoadingAnimationWidget(height: 100, width: 200),
              ),
            ),
            Text(
              'Actions',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildActionsRow(
                  icon: Icons.note_outlined,
                  title: 'Notes',
                  onTap: () {
                    // DialogBoxWidget(
                    //   title: 'Notes',
                    //   onSave: () {},
                    //   onCancel: () {},
                    //   child: Column(children: []),
                    // );
                  },
                ),
                _buildActionsRow(
                  icon: Icons.edit_outlined,
                  title: 'Edit',
                  onTap: () {},
                ),
                _buildActionsRow(
                  icon: Icons.delete_outline,
                  title: 'Delete',
                  onTap: () {},
                ),
                _buildActionsRow(
                  icon: Icons.file_copy_outlined,
                  title: 'Files',
                  onTap: () {},
                ),
                _buildActionsRow(
                  icon: Icons.dashboard_customize_outlined,
                  title: 'New Project',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Customer Details Row
  Widget _buildDetailsRow({required String title, required String value}) =>
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.secondaryGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Divider(),
          SizedBox(height: 10),
        ],
      );

  // Customer Actions Section
  Widget _buildActionsRow({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) => InkWell(
    onTap: onTap ?? () {},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greenBorder),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButtonWidget(icon: icon, padding: 5),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
    ),
  );

  // Customer Projects Section
  Widget _buildCustomerProjects({
    required BuildContext context,
    required double screenHeight,
    required double screenWidth,
    required CustomerDashboardPageViewModel viewModel,
  }) => Material(
    elevation: 5,
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
    child: Container(
      height: screenHeight * 0.7,
      width: screenWidth * 0.65,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.greenBorder),
          bottom: BorderSide(color: AppColors.greenBorder),
          right: BorderSide(color: AppColors.greenBorder),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Projects',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Divider(),
            SizedBox(height: 20),
            StreamBuilderWidget<List<ProjectModel>>(
              stream: viewModel.fetchProjectsList(parentContext: context),
              // isEmpty: (data) => data == null || data.isEmpty,
              builder: (context, projectsList) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      projectsList.map((project) {
                        return _buildProjectsRow(
                          projectName: project.name,
                          projectDescription: project.description,
                          onTap: () {
                            context.goNamed(
                              RouteNames.customerProjectDetailsPage,
                              pathParameters: {'projectName': project.name},
                            );
                          },
                        );
                      }).toList(),
                );
              },
              loadingWidget: LoadingAnimationWidget(),
              emptyWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_outlined, color: AppColors.darkGreenIcon),
                  SizedBox(width: 10),
                  Text(
                    'No projects found',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.darkGreenText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // Projects Row
  Widget _buildProjectsRow({
    IconData icon = Icons.add_photo_alternate,
    required String projectName,
    required String projectDescription,
    VoidCallback? onTap,
  }) => InkWell(
    onTap: onTap ?? () {},
    borderRadius: BorderRadius.circular(5),
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greenBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButtonWidget(icon: icon, padding: 5),
              SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: Text(
                  projectName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.darkGreenText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: Text(
              projectDescription,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );

  // Add new customer dialog box
  Future<void> addNewProjectDialogBox({
    required BuildContext parentContext,
    required CustomerDashboardPageViewModel viewModel,
    required PageController pageController,

    required int currentPage,
  }) {
    // final TextEditingController firstNameController = TextEditingController();
    // final TextEditingController lastNameController = TextEditingController();
    // final TextEditingController secondaryNameController =
    //     TextEditingController();
    // final TextEditingController secondaryLastNameController =
    //     TextEditingController();
    // final TextEditingController phoneController = TextEditingController();
    // final TextEditingController mobileController = TextEditingController();
    // final TextEditingController addressController = TextEditingController();
    // final TextEditingController unitController = TextEditingController();
    // final TextEditingController emailController = TextEditingController();

    return DialogBoxWidget.show(
      parentContext: parentContext,
      title: 'Add New Project',
      isBackOnSave: false,
      content: _buildTwoPages(
        parentContext: parentContext,
        pageController: pageController,
        currentPage: currentPage,
        viewModel: viewModel,
      ),
      actionButtons:
          (dialogBoxContext) => _buildActionButtons(
            parentContext: parentContext,
            dialogBoxContext: dialogBoxContext,
            currentPage: currentPage,
            pageController: pageController,
          ),
      onSave: (dialogBoxContext) async {
        // final customerDetails = AddCustomerModel(
        //   firstName: firstNameController.text,
        //   lastName: lastNameController.text,
        //   secondaryName: secondaryNameController.text,
        //   secondaryLastName: secondaryLastNameController.text,
        //   phone: phoneController.text,
        //   mobile: mobileController.text,
        //   address: addressController.text,
        //   unit: unitController.text,
        //   email: emailController.text,
        // );
        // await viewModel.addCustomerProject(
        //   projectDetails: projectDetails.toJson(),
        // );
      },
    );
  }

  // Two Pages for dialog box
  Widget _buildTwoPages({
    required BuildContext parentContext,
    required PageController pageController,
    required int currentPage,
    required CustomerDashboardPageViewModel viewModel,
  }) {
    final addressController = TextEditingController();
    final unitController = TextEditingController();
    final ahjController = TextEditingController();
    final projectPriceController = TextEditingController();

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: 600,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) => setState(() => currentPage = index),
                  children: [
                    // First Page
                    SingleChildScrollView(
                      child: Form(
                        key: _pageOneFormKey,
                        child: Column(
                          children: [
                            TextFieldWidget(
                              title: 'Project Address',
                              controller: addressController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Project Address is required';
                                }
                                return null;
                              },
                            ),
                            _buildCustomDropdown(
                              title: 'Continue?',
                              selectedValue: viewModel.selectedContinueValue,
                              selectedValuesList: viewModel.continueValuesList,
                            ),

                            TextFieldWidget(
                              title: 'Unit',
                              controller: unitController,
                            ),
                            TextFieldWidget(
                              title: 'AHJ',
                              controller: ahjController,
                            ),
                            _buildCustomDropdown(
                              title: 'Customer Name',
                              selectedValue:
                                  viewModel.selectedCustomerNameValue,
                              selectedValuesList:
                                  viewModel.customerNameValuesList,
                            ),
                            TextFieldWidget(
                              title: 'Customer Email',
                              controller: ahjController,
                              isTextFieldEnabled: false,
                              hintText: 'ahsan@skynet.com',
                            ),
                            TextFieldWidget(
                              title: 'Customer Phone',
                              controller: ahjController,
                              isTextFieldEnabled: false,
                              hintText: '03023878499',
                            ),
                            _buildCustomDropdown(
                              title: 'Branch Name',
                              selectedValue: viewModel.selectedBranchNameValue,
                              selectedValuesList:
                                  viewModel.branchNameValuesList,
                            ),

                            TextFieldWidget(
                              title: 'Project Price',
                              controller: projectPriceController,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Second Page
                    SingleChildScrollView(
                      child: Form(
                        key: _pageTwoFormKey,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(color: AppColors.secondaryGreen),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Action buttons for add new project dialog box
  List<Widget> _buildActionButtons({
    required BuildContext parentContext,
    required BuildContext dialogBoxContext,
    required int currentPage,
    required PageController pageController,
  }) => [
    currentPage == 0
        ? TextButton(
          onPressed: () => Navigator.of(dialogBoxContext).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.darkGreenText),
          ),
        )
        : ElevatedButton(
          onPressed:
              () => pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Back'),
        ),
    currentPage == 1
        ? ElevatedButton(
          onPressed: () {
            if (_pageOneFormKey.currentState!.validate()) {
              Navigator.of(dialogBoxContext).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Save'),
        )
        : ElevatedButton(
          onPressed: () {
            if (_pageOneFormKey.currentState!.validate()) {
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Next'),
        ),
  ];

  // Custom dropdown
  Widget _buildCustomDropdown({
    required String title,
    required String selectedValue,
    required List<String> selectedValuesList,
  }) => Consumer<CustomerDashboardPageViewModel>(
    builder: (context, value, child) {
      return DropdownWidget(
        title: title,
        items: selectedValuesList,
        value: selectedValue,
        onChanged: (String? newValue) {
          value.updateDropDownValue(
            selectedValue: selectedValue,
            newValue: newValue!,
          );
        },
        itemLabelBuilder: (item) => item,
      );
    },
  );
}
