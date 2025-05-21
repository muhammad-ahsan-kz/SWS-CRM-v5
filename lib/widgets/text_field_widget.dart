import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isTextFieldEnabled;
  final String hintText;

  const TextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.isTextFieldEnabled = true,
    this.hintText = '',
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
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: isTextFieldEnabled,

          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
