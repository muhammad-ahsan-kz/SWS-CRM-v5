import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class SuperAdminPage extends StatelessWidget {
  const SuperAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menusList = [
      {'icon': Icons.arrow_drop_down_circle_outlined, 'title': 'Dropdowns'},
      {'icon': Icons.settings, 'title': 'General Settings'},
      {'icon': Icons.supervisor_account_outlined, 'title': 'Super Admin Users'},
      {'icon': Icons.security, 'title': 'Role Management'},
      {'icon': Icons.location_on_outlined, 'title': 'Zip Codes'},
      {'icon': Icons.calendar_month, 'title': 'Weekly Calendar'},
      {
        'icon': Icons.notifications_active_outlined,
        'title': 'Notifications Management',
      },
      {'icon': Icons.storage_outlined, 'title': 'Database'},
      {'icon': Icons.menu_open, 'title': 'Side Menus'},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Super Admin',
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.boxBorder),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(menu['icon'], color: AppColors.darkGreenIcon),
                    SizedBox(width: 10),
                    Text(menu['title']),
                  ],
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
