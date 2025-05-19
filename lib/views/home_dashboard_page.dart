import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> dummyFavouritesMenuList = [
      'Dropdowns',
      'Branches',
      'Project 5',
    ];
    final List<String> dummyFavouriteProjectsList = [
      'CRM Redesign',
      'Marketing Site Revamp',
      'Internal Tools',
      'Mobile App UI',
      'Food Delivery System',
      'VsCode',
      'Android Studio',
      'Postman',
    ];

    final List<String> dummyNotificationsList = [
      'New user registered',
      'Password changed successfully',
      'Project deadline extended',
      'Database backup completed',
      'New message from admin',
      'Weekly summary is ready',
      'Role permissions updated',
      'Server maintenance scheduled',
      'New document uploaded',
      'Task "UI Design" marked complete',
      'Login from new device detected',
      'Zip code list updated',
      'New feedback received',
      'Side menu updated',
      'System settings changed',
    ];

    return LayoutBuilder(
      builder: (context, constraits) {
        final double screenHeight = constraits.maxHeight;
        final double screenWidth = constraits.maxWidth;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Favourites Menu, Projects and Message Box
            Container(
              height: screenHeight,
              width: screenWidth * 0.45,
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  // Column child row
                  SizedBox(
                    height: screenHeight * 0.45,
                    child: Row(
                      children: [
                        // Favourites Menu
                        Container(
                          height: screenHeight * 0.5,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              _buildMenuTitle(
                                icon: Icons.star_outline,
                                title: 'Favourites Menu',
                              ),
                              _buildListItems(
                                itemsList: dummyFavouritesMenuList,
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: AppColors.primaryGreen,
                          thickness: 1,
                          width: 20,
                        ),
                        // Favourite Projects
                        Container(
                          height: screenHeight * 0.5,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              _buildMenuTitle(
                                icon: Icons.folder_open,
                                title: 'Favourite Projects',
                              ),
                              _buildListItems(
                                itemsList: dummyFavouriteProjectsList,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.primaryGreen, thickness: 1),
                  // Message Box
                  Container(
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        _buildMenuTitle(
                          icon: Icons.mail_outline,
                          title: 'Message Box',
                        ),
                        Container(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Projects',
                                  style: TextStyle(
                                    color: AppColors.darkGreenText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.15,
                                    height: screenHeight * 0.35,
                                    child: _buildListItems(
                                      itemsList: dummyFavouriteProjectsList,
                                      showIcon: false,
                                      itemOpacity: 0,
                                    ),
                                  ),
                                  VerticalDivider(thickness: 1, width: 20),
                                  Container(
                                    width: screenWidth * 0.25,
                                    height: screenHeight * 0.3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: AppColors.primaryGreen,
              thickness: 1,
              width: 20,
            ),
            // Notifications
            Container(
              height: screenHeight,
              width: screenWidth * 0.45,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  _buildMenuTitle(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                  ),
                  _buildListItems(
                    itemsList: dummyNotificationsList,
                    showIcon: false,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Menu title
  Widget _buildMenuTitle({required IconData icon, required String title}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.darkGreenIcon),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.darkGreenText,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      );

  // List of values
  Widget _buildListItems({
    required List<String> itemsList,
    bool showIcon = true,
    double itemOpacity = 0.2,
  }) => Expanded(
    child: ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: itemsList.length,

      itemBuilder: (context, index) {
        final item = itemsList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: itemOpacity),
          ),
          child: ListTile(
            leading:
                showIcon
                    ? Icon(Icons.star, size: 20, color: AppColors.yellow)
                    : SizedBox(),
            title: Text(item, style: TextStyle(fontSize: 13)),
          ),
        );
      },
    ),
  );

  // Message box
  // Widget _buildMessageBox() =>
}
