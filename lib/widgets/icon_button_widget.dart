import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback? ontap;
  final IconData icon;
  final double borderRadius;
  final double padding;
  final Color color;
  final double size;

  const IconButtonWidget({
    super.key,
    this.ontap,
    required this.icon,
    this.borderRadius = 50,
    this.padding = 0,
    this.color = AppColors.darkGreenIcon,
    this.size = 25,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ?? () {},
      borderRadius: BorderRadius.circular(borderRadius),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
