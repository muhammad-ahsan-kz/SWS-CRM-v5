import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class NewButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback ontap;
  const NewButton({
    super.key,
    required this.title,
    required this.icon,
    this.backgroundColor = AppColors.grey,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(50),
          hoverColor: AppColors.background.withValues(alpha: 0.3),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              // color: backgroundColor.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.darkGreenIcon),
                SizedBox(width: 8),
                Text(title, style: TextStyle(color: AppColors.darkGreenText)),
              ],
            ),
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}
