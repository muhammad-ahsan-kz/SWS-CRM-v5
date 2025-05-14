import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            // alignment: WrapAlignment.center,
            children: [
              _buildCustomCard(
                context: context,
                title: 'Favorites Menu',
                isButtonDefined: true,
                itemsList: [
                  {'title': 'Dropdowns'},
                  {'title': 'Items'},
                ],
              ),
              _buildCustomCard(
                context: context,
                title: 'Favorites Projects',
                itemsList: [],
              ),
              _buildCustomCard(
                context: context,
                title: 'Notifications',
                isButtonDefined: true,
                buttonIcon: Icons.history,
                buttonText: 'History',
                itemsList: [],
              ),
              _buildCustomCard(
                context: context,
                title: 'Message Box',
                itemsList: [],
              ),
              _buildCustomCard(
                context: context,
                title: 'Event Notifications',
                containerHeight: 600,
                itemsList: [],
              ),
              _buildCustomCard(
                context: context,
                title: 'Tasks',
                isButtonDefined: true,
                containerHeight: 600,
                itemsList: [],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card
  Widget _buildCustomCard({
    required BuildContext context,
    required String title,
    double containerHeight = 350,
    double containerWidth = 450,
    bool isButtonDefined = false,
    String buttonText = 'Add',
    IconData buttonIcon = Icons.add,
    required List<Map<String, dynamic>> itemsList,
    // VoidCallback  onButtonTap = (){},
  }) {
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
                        onPressed: () => showCustomDialog(context),
                        icon: Icon(buttonIcon),
                        label: Text(buttonText),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.darkGreenText,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: AppColors.boxBorder),
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

  void showCustomDialog(BuildContext context) {
    final TextEditingController field1Controller = TextEditingController();
    final TextEditingController field2Controller = TextEditingController();
    final TextEditingController field3Controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Add Favorites',
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLabeledTextField('Menu', field1Controller),
                SizedBox(height: 10),
                _buildLabeledTextField('Role', field2Controller),
                SizedBox(height: 10),
                _buildLabeledTextField('Link', field3Controller),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryGreen),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle save logic here
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreenIcon,
                foregroundColor: Colors.white,
              ),
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLabeledTextField(
    String label,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
      ],
    );
  }
}
