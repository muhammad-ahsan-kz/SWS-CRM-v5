import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class DropdownWidget<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabelBuilder;

  const DropdownWidget({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemLabelBuilder,
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
        DropdownButtonFormField<T>(
          value: value,
          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemLabelBuilder(item)),
                );
              }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
