import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';

class DialogBoxWidget extends StatelessWidget {
  final String title;
  final Widget content;
  final void Function(BuildContext dialogBoxContext) onSave;
  final double dialogBoxHeight;
  final double dialogBoxWidth;
  final bool isBackOnSave;
  final List<Widget> Function(BuildContext dialogBoxContext)? actionButtons;

  const DialogBoxWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onSave,
    this.dialogBoxHeight = 600,
    this.dialogBoxWidth = 500,
    this.isBackOnSave = true,
    this.actionButtons,
  });

  @override
  Widget build(BuildContext dialogBoxContext) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.darkGreenText,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButtonWidget(
            icon: Icons.close,
            padding: 10,
            ontap: () => Navigator.of(dialogBoxContext).pop(),
          ),
        ],
      ),
      content: SizedBox(
        height: dialogBoxHeight,
        width: dialogBoxWidth,
        child: SingleChildScrollView(child: content),
      ),
      actions:
          actionButtons != null
              ? actionButtons!(dialogBoxContext)
              : [
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
    double dialogBoxHeight = 600,
    double dialogBoxWidth = 500,

    List<Widget> Function(BuildContext dialogBoxContext)? actionButtons,
  }) {
    return showDialog(
      context: parentContext,
      builder:
          (ctx) => DialogBoxWidget(
            title: title,
            content: content,
            onSave: onSave,
            isBackOnSave: isBackOnSave,
            dialogBoxHeight: dialogBoxHeight,
            dialogBoxWidth: dialogBoxWidth,
            actionButtons: actionButtons,
          ),
    );
  }
}
