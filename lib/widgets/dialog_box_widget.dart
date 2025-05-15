import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class DialogBoxWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBoxWidget({
    super.key,
    required this.title,
    required this.child,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBoxWidget> createState() => _DialogBoxWidgetState();
}

class _DialogBoxWidgetState extends State<DialogBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        widget.title,
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(width: 400, child: widget.child),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCancel();
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.secondaryGreen),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGreenIcon,
            foregroundColor: Colors.white,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
