import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class SuperAdminPage extends StatefulWidget {
  const SuperAdminPage({super.key});

  @override
  State<SuperAdminPage> createState() => _SuperAdminPageState();
}

class _SuperAdminPageState extends State<SuperAdminPage> {
  int selectedMenuIndex = 0;
  final Map<int, List<String>> subMenus = {
    0: [
      "All",
      "Autopay",
      "Battery Installed Stat…",
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
    2: ["All", "FINANCE MANAGER", "PRODUCTION MANAGER", "SUPER ADMIN"],
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
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Super Admin',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(height: 10),
            _buildOptionsList(menusList: menusList),
            if (subMenus[selectedMenuIndex] != null) const SizedBox(height: 20),
            if (subMenus[selectedMenuIndex] != null)
              _buildSubMenusList(subMenus[selectedMenuIndex]!),
          ],
        ),
      ),
    );
  }

  // Super Admin Menu Items List
  Widget _buildOptionsList({required List<Map<String, dynamic>> menusList}) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menusList.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> menu = menusList[index];
          return Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedMenuIndex = selectedMenuIndex == index ? 0 : index;
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
    );
  }

  // Sub Menus
  Widget _buildSubMenusList(List<String> subItems) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children:
          subItems.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: 0.2),
                border: Border.all(color: AppColors.boxBorder),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item,
                style: TextStyle(color: AppColors.darkGreenText),
              ),
            );
          }).toList(),
    );
  }
}
