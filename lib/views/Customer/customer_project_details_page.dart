import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';

import '../../utils/app_colors.dart';

class CustomerProjectDetailsPage extends StatelessWidget {
  final String projectId;
  const CustomerProjectDetailsPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildCustomerHeader(),
              // const SizedBox(height: 30),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     _buildCustomerDetails(screenHeight, screenWidth),
              //     _buildCustomerProjects(context, screenHeight, screenWidth),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project Dashboard',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      SizedBox(width: 150, child: Divider()),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildCustomCard(
                    context: context,
                    title: 'Project Info',
                    itemsList: [],
                  ),
                  _buildCustomCard(
                    context: context,
                    title: 'Production Info',
                    itemsList: [],
                  ),
                  _buildCustomCard(
                    context: context,
                    title: 'Project Finance',
                    itemsList: [],
                  ),
                  _buildCustomCard(
                    context: context,
                    title: 'Payments',
                    itemsList: [],
                  ),
                  _buildCustomCard(
                    context: context,
                    title: 'Permits',
                    itemsList: [],
                  ),
                  _buildCustomCard(
                    context: context,
                    title: 'Chat Room',
                    itemsList: [],
                  ),
                  _buildCustomCard(
                    context: context,
                    title: 'Events',
                    itemsList: [],
                  ),
                  _buildCustomCard(
                    context: context,
                    title: 'Notes',
                    itemsList: [],
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
  Widget _buildCustomerHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),
            Text(
              'Welcome back Trygge Toven',
              // 'Welcome back ${customerDetails.fullName}',
              style: TextStyle(
                fontSize: 12,
                // fontWeight: FontWeight.bold,
                color: AppColors.lightGreen,
              ),
            ),
          ],
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
    );
  }

  // Customer Dashboard Details Box
  // Widget _buildCustomerDetails() {
  //   return Card(
  //     elevation: 8,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //     child: Container(
  //       width: 400,
  //       padding: const EdgeInsets.all(24),
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [AppColors.white, Colors.green.shade100],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildRow('Customer ID', '3fe887d3'),
  //           _buildRow('Full Name', 'Trygge Toven'),
  //           _buildRow(
  //             'Address',
  //             '11540 Cumpston St, North Hollywood, CA 91601, USA',
  //           ),
  //           _buildRow('Phone', '2536779841'),
  //           _buildRow('Email', 'ttoven@gmail.com'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildRow(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: RichText(
  //       text: TextSpan(
  //         style: const TextStyle(fontSize: 16, color: Colors.black),
  //         children: [
  //           TextSpan(
  //             text: '$label: ',
  //             style: const TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.teal,
  //             ),
  //           ),
  //           TextSpan(text: value),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Customer Dashboard Details Box
  Widget _buildCustomerDetails(double screenHeight, double screenWidth) {
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
          // gradient: LinearGradient(
          //   colors: [
          //     AppColors.lightGreen.withValues(alpha: .3),
          //     AppColors.lightGreen2.withValues(alpha: .3),
          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
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
            _buildDetailsRow(
              title: 'Customer Id',
              // value: customerDetails.customerId,
              value: '3fe887d3',
            ),
            _buildDetailsRow(
              title: 'Full Name',
              // value: customerDetails.fullName,
              value: 'Trygge Toven',
            ),
            _buildDetailsRow(
              title: 'Address',
              //  value: customerDetails.address
              value: '11540 Cumpston St, North Hollywood, CA 91601, USA',
            ),
            _buildDetailsRow(
              title: 'Phone',
              //  value: customerDetails.phone
              value: '2536779841',
            ),
            _buildDetailsRow(
              title: 'Email',
              // value: customerDetails.email
              value: 'ttoven@gmail.com',
            ),
            SizedBox(height: 30),
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
  Widget _buildCustomerProjects(
    BuildContext context,
    double screenHeight,
    double screenWidth,
  ) => Material(
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
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int i = 1; i < 10; i++)
                  _buildProjectsRow(
                    projectName: 'Project $i',
                    projectDescription: 'This is a dummy project',
                    onTap: () {
                      context.goNamed(RouteNames.customerProjectDetailsPage);
                    },
                  ),
              ],
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

  // Card
  Widget _buildCustomCard({
    required BuildContext context,
    required String title,
    double containerHeight = 350,
    double containerWidth = 450,
    bool isButtonDefined = false,
    String buttonText = 'Add',
    IconData buttonIcon = Icons.add,
    required List<Map<String, dynamic>> itemsList,
    // VoidCallback  onButtonTap = (){},
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: AppColors.background,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: containerHeight < 300 ? 350 : containerHeight,
        width: containerWidth < 400 ? 450 : containerWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.greenBorder),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.dashboard_customize,
                      color: AppColors.darkGreenText,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (isButtonDefined)
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(buttonIcon),
                        label: Text(buttonText),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.darkGreenText,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: AppColors.greenBorder),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.check_box, size: 18),
                      onPressed: () {},
                      color: AppColors.secondaryGreen,
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list, size: 18),
                      onPressed: () {},
                      color: AppColors.secondaryGreen,
                    ),
                    IconButton(
                      icon: Icon(Icons.open_in_full, size: 18),
                      onPressed: () {},
                      color: AppColors.secondaryGreen,
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            const SizedBox(height: 16),

            /// Item list
            itemsList.isEmpty
                ? Expanded(
                  child: Center(
                    child: Text(
                      'No Items',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.darkGreenText,
                      ),
                    ),
                  ),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: itemsList.length,
                    itemBuilder: (context, index) {
                      final item = itemsList[index];
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen2,

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.subdirectory_arrow_right,
                                color: AppColors.darkGreenIcon,
                              ),
                              title: Text(item['title']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.primaryGreen,
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.copy,
                                    color: AppColors.primaryGreen,
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.delete_outline,
                                    color: AppColors.redAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
