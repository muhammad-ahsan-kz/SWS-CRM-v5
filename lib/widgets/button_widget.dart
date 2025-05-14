import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final double elevation;
  final bool isIconShown;
  final double textSize;
  final double iconSize;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.title,
    this.icon = Icons.add,
    this.backgroundColor = AppColors.background,
    this.foregroundColor = AppColors.white,
    this.borderRadius = 50,
    this.elevation = 0,
    this.isIconShown = false,
    this.textSize = 12,
    this.iconSize = 15,
    this.horizontalPadding = 10,
    this.verticalPadding = 5,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            children: [
              if (isIconShown)
                Icon(icon, color: foregroundColor, size: iconSize),
              if (isIconShown) SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(color: foregroundColor, fontSize: textSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
