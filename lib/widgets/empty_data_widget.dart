import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyDataWidget({
    super.key,
    this.message = 'No data available.',
    this.icon = Icons.folder_open,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.lightGreen2.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGreen),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: AppColors.primaryGreen),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.darkGreenText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
