import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const TextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryGreen,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
    ;
  }
}
