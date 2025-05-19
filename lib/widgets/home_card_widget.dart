import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/widgets/dialog_box_widget.dart';

class HomeCardWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final double containerHeight;
  final double containerWidth;
  final bool isButtonDefined;
  final String buttonText;
  final IconData buttonIcon;
  final List<Map<String, dynamic>> itemsList;
  final VoidCallback? onButtonTap;

  const HomeCardWidget({
    super.key,

    required this.context,
    required this.title,
    this.containerHeight = 350,
    this.containerWidth = 450,
    this.isButtonDefined = false,
    this.buttonText = 'Add',
    this.buttonIcon = Icons.add,
    required this.itemsList,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: AppColors.background,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: containerHeight < 300 ? 350 : containerHeight,
        width: containerWidth < 400 ? 450 : containerWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.greenBorder),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                Row(
                  children: [
                    if (isButtonDefined)
                      ElevatedButton.icon(
                        onPressed:
                            () => DialogBoxWidget.show(
                              parentContext: context,
                              title: title,
                              content: Column(children: []),
                              onSave: () {},
                            ),
                        icon: Icon(buttonIcon),
                        label: Text(buttonText),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.darkGreenText,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: AppColors.greenBorder),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.check_box),
                      onPressed: () {},
                      color: AppColors.secondaryGreen,
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {},
                      color: AppColors.secondaryGreen,
                    ),
                    IconButton(
                      icon: Icon(Icons.open_in_full),
                      onPressed: () {},
                      color: AppColors.secondaryGreen,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Item list
            itemsList.isEmpty
                ? Expanded(
                  child: Center(
                    child: Text(
                      'No Items',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.darkGreenText,
                      ),
                    ),
                  ),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: itemsList.length,
                    itemBuilder: (context, index) {
                      final item = itemsList[index];
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen2,

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.subdirectory_arrow_right,
                                color: AppColors.darkGreenIcon,
                              ),
                              title: Text(item['title']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.primaryGreen,
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.copy,
                                    color: AppColors.primaryGreen,
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.delete_outline,
                                    color: AppColors.redAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
