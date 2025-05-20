import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class DialogBoxWidget extends StatelessWidget {
  final String title;
  final Widget content;
  final void Function(BuildContext dialogBoxContext) onSave;
  final double dialogBoxHeight;
  final double dialogBoxWidth;
  final bool isBackOnSave;

  const DialogBoxWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onSave,
    this.dialogBoxHeight = 600,
    this.dialogBoxWidth = 500,
    this.isBackOnSave = true,
  });

  @override
  Widget build(BuildContext dialogBoxContext) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.darkGreenText,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        height: dialogBoxHeight,
        width: dialogBoxWidth,
        child: SingleChildScrollView(child: content),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogBoxContext).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.darkGreenText),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onSave(dialogBoxContext);
            if (isBackOnSave) Navigator.of(dialogBoxContext).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }

  /// Static method to show the dialog from anywhere
  static Future<void> show({
    required BuildContext parentContext,
    required String title,
    required Widget content,
    required void Function(BuildContext dialogBoxContext) onSave,
    bool isBackOnSave = true,
  }) {
    return showDialog(
      context: parentContext,
      builder:
          (ctx) => DialogBoxWidget(
            title: title,
            content: content,
            onSave: onSave,
            isBackOnSave: isBackOnSave,
          ),
    );
  }
}
