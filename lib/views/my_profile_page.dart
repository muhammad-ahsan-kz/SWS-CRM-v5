import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  ButtonWidget(
                    title: 'Add',
                    onTap: () {
                      // showCustomDialog(context: context, subMenuName: 'Add');
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
        ],
      ),
    );
  }
}
