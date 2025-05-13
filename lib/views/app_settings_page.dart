import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menusList = [
      {'icon': Icons.group_outlined, 'title': 'Users'},
      {'icon': Icons.settings, 'title': 'General Settings'},
      {'icon': Icons.badge_outlined, 'title': 'Sales Reps'},
      {'icon': Icons.business_outlined, 'title': 'Vendors'},
      {'icon': Icons.delete_outline, 'title': 'Deleted Projects'},
      {'icon': Icons.arrow_drop_down_circle_outlined, 'title': 'Dropdowns'},
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notifications Management',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(height: 10),
            _buildOptionsList(menusList: menusList),
          ],
        ),
      ),
    );
  }

  // Super Admin Menu Items List
  Widget _buildOptionsList({required List<Map<String, dynamic>> menusList}) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menusList.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> menu = menusList[index];
          return Row(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.boxBorder),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(menu['icon'], color: AppColors.darkGreenIcon),
                      SizedBox(width: 10),
                      Text(
                        menu['title'],
                        style: TextStyle(color: AppColors.black),
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
    );
  }
}
