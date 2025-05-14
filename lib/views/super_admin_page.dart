import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/icon_button_widget.dart';
import 'package:sws_crm_v5/widgets/table_widget.dart';

class SuperAdminPage extends StatefulWidget {
  const SuperAdminPage({super.key});

  @override
  State<SuperAdminPage> createState() => _SuperAdminPageState();
}

class _SuperAdminPageState extends State<SuperAdminPage> {
  int selectedMenuIndex = 0;
  String? selectedSubMenuItem;
  final ScrollController _menuScrollController = ScrollController();
  final Map<int, List<String>> subMenus = {
    0: [
      "All",
      "Autopay",
      "Battery Installed Status",
      "Branch",
      "Calendar Limit",
      "Completion Status",
      "Department",
      "ESR",
      "Electrician",
      "Event Confirmed",
      "Event Status",
      "Event Type",
      "Final Status",
      "Finance Company",
      "Finance Status",
      "Finance Type",
      "Fund Status",
      "Inspection Status",
      "Installer Crew",
      "Inverter Type",
      "Job Status",
      "MPU Installed Status",
      "MPU Location",
      "Notification Message",
      "Payment Type",
    ],
    1: [],
    2: ["All", "Finance Manager", "Production Manager", "Super Admin"],
    3: [
      "Project Manager",
      "Dispatch",
      "Finance VA",
      "Finance Manager",
      "VA",
      "Admin",
      "Roofing Manager",
      "Permit Tech",
      "Production Manager",
      "T/S Manager",
      "Super Admin",
      "T/S Rep",
      "Rep",
      "Engineers",
      "Technician",
      "Installer",
      "Vendor",
      "Vendor Manager",
    ],
    4: [],
    5: [],
    6: ["All", "Finance", "Notes", "Permits", "Projects"],
    7: [],
    8: [
      "Customers",
      "Help",
      "Production",
      "Events",
      "App Settings",
      "TroubleShooting",
      "Reports",
    ],
  };

  final Map<String, List<String>> optionsList = {
    "All": ["Attension", "Pending Plan Corrections", "Pending MPU Install"],
    "Autopay": ["With", "Without"],
    "Branch": ["BHP", "BSP", "DSC", "MOD"],
  };
  @override
  void initState() {
    super.initState();

    final initialSubMenuList = subMenus[selectedMenuIndex];
    if (initialSubMenuList != null && initialSubMenuList.isNotEmpty) {
      selectedSubMenuItem = initialSubMenuList.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> menusList = [
      {'icon': Icons.arrow_drop_down_circle_outlined, 'title': 'Dropdowns'},
      {'icon': Icons.settings, 'title': 'General Settings'},
      {'icon': Icons.supervisor_account_outlined, 'title': 'Super Admin Users'},
      {'icon': Icons.security, 'title': 'Role Management'},
      {'icon': Icons.location_on_outlined, 'title': 'Zip Codes'},
      {'icon': Icons.calendar_month, 'title': 'Weekly Calendar'},
      {
        'icon': Icons.notifications_active_outlined,
        'title': 'Notifications Management',
      },
      {'icon': Icons.storage_outlined, 'title': 'Database'},
      {'icon': Icons.menu_open, 'title': 'Side Menus'},
    ];

    final names =
        selectedSubMenuItem != null
            ? (optionsList[selectedSubMenuItem!] ?? [])
            : [];

    final rowsValuesList = names.map((name) => {'Name': name}).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Super Admin',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                Row(
                  spacing: 10,
                  children: [
                    ButtonWidget(
                      title: 'Add',
                      onTap: () {},
                      isIconShown: true,
                      textSize: 15,
                      iconSize: 18,
                      horizontalPadding: 20,
                      verticalPadding: 8,
                    ),
                    IconButtonWidget(icon: Icons.filter_list, padding: 5),
                    IconButtonWidget(icon: Icons.done_all, padding: 5),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildMenusList(menusList: menusList),
            const SizedBox(height: 20),

            // if (subMenus[selectedMenuIndex] != null &&
            //     subMenus[selectedMenuIndex]!.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectedSubMenuItem == null
                    ? SizedBox()
                    : _buildSubMenusList(
                      subMenusList: subMenus[selectedMenuIndex]!,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                SizedBox(width: 15),
                if ((selectedSubMenuItem != null &&
                    optionsList[selectedSubMenuItem!] == null))
                  TableWidget(
                    columnNamesList: ['Name'],
                    rowsValuesList: rowsValuesList,
                    tableWidth: screenWidth * 0.7,
                    tableHeight: screenHeight * 0.6,
                  )
                else if (selectedSubMenuItem != null &&
                    optionsList[selectedSubMenuItem!] != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _buildOptionsList(
                        //   optionsList: optionsList[selectedSubMenuItem!]!,
                        // ),
                        // SizedBox(height: 10),
                        TableWidget(
                          columnNamesList: ['Name'],
                          rowsValuesList: rowsValuesList,
                          tableWidth: screenWidth * 0.7,
                          tableHeight: screenHeight * 0.6,
                          rowTopBottomPadding: 0,
                          actionBuilder: (rowData, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButtonWidget(
                                  ontap: () {
                                    showCustomDialog(
                                      context: context,
                                      subMenuName: rowData['Name'],
                                    );
                                  },
                                  icon: Icons.edit,
                                  padding: 5,
                                ),
                                IconButtonWidget(
                                  icon: Icons.delete,
                                  padding: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  )
                else
                  TableWidget(
                    columnNamesList: ['Name'],
                    rowsValuesList: rowsValuesList,
                    tableWidth: screenWidth * 0.7,
                    tableHeight: screenHeight * 0.6,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Menu Items List
  Widget _buildMenusList({required List<Map<String, dynamic>> menusList}) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: true,
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: Scrollbar(
          thumbVisibility: true,
          controller: _menuScrollController,
          child: ListView.builder(
            controller: _menuScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: menusList.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> menu = menusList[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedMenuIndex =
                            selectedMenuIndex == index ? 0 : index;
                        final submenuList = subMenus[selectedMenuIndex];
                        if (submenuList != null && submenuList.isNotEmpty) {
                          selectedSubMenuItem = submenuList.first;
                        } else {
                          selectedSubMenuItem = null;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            selectedMenuIndex == index
                                ? AppColors.background
                                : AppColors.white,
                        border: Border.all(color: AppColors.boxBorder),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            menu['icon'],
                            color:
                                selectedMenuIndex == index
                                    ? AppColors.white
                                    : AppColors.darkGreenIcon,
                          ),
                          SizedBox(width: 10),
                          Text(
                            menu['title'],
                            style: TextStyle(
                              color:
                                  selectedMenuIndex == index
                                      ? AppColors.white
                                      : AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Sub Menu Items List
  Widget _buildSubMenusList({
    required List<String> subMenusList,
    required double screenHeight,
    required double screenWidth,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.7),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.2),
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          itemCount: subMenusList.length,
          itemBuilder: (context, index) {
            final item = subMenusList[index];
            return Container(
              color:
                  selectedSubMenuItem == item
                      ? AppColors.background
                      : AppColors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedSubMenuItem = item;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    subMenusList[index],
                    style: TextStyle(
                      color:
                          selectedSubMenuItem == item
                              ? AppColors.white
                              : AppColors.black,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Dialog Box
  void showCustomDialog({
    required BuildContext context,
    required String subMenuName,
  }) {
    final TextEditingController field1Controller = TextEditingController();
    final TextEditingController field2Controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            subMenuName,
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
                _buildLabeledTextField('Type', field1Controller),
                SizedBox(height: 10),
                _buildLabeledTextField('Color', field2Controller),
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

  // Text Field
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
