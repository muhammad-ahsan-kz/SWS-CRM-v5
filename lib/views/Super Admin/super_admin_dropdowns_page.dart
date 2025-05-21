import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class SuperAdminDropdownsPage extends StatelessWidget {
  const SuperAdminDropdownsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Text(
        'DropDowns',
        style: TextStyle(fontSize: 20, color: AppColors.darkGreenText),
      ),
    );
  }
}
