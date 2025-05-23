import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  String? expandedItem;
  bool isSidebarExpanded = true; // starts as expanded
  double sidebarWidth = 250; // initial width

  void toggleSidebar() {
    setState(() {
      isSidebarExpanded = !isSidebarExpanded;
      sidebarWidth = isSidebarExpanded ? 250 : 120;
    });
  }

  void handleMenuTap(bool isSelected) {
    setState(() {
      isSidebarExpanded = isSelected;
      sidebarWidth = isSidebarExpanded ? 250 : 120;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.path;

    final menuItems = [
      SidebarItem(
        title: 'Home',
        icon: Icons.home,
        route: RouteNames.homeDashboardPage,
        subItems: [
          SidebarItem(
            title: 'Event Notifications',
            route: RouteNames.homeEventNotificationsPage,
          ),
          SidebarItem(title: 'Tasks', route: RouteNames.homeTasksPage),
        ],
      ),
      SidebarItem(
        title: 'Super Admin',
        icon: Icons.admin_panel_settings,
        subItems: [
          SidebarItem(
            title: 'Dropdowns',
            route: RouteNames.superAdminDropdownsPage,
          ),
          SidebarItem(
            title: 'General Settings',
            route: RouteNames.superAdminGeneralSettingsPage,
          ),
          // SidebarItem(  title: 'Super Admin Users', route: RouteNames. ),
          // SidebarItem(  title: 'Role Management', route: RouteNames. ),
          // SidebarItem(  title: 'Zip Codes', route: RouteNames. ),
          // SidebarItem(  title: 'Weekly Calander', route: RouteNames. ),
          // SidebarItem(  title: 'Notification Management', route: RouteNames. ),
          // SidebarItem(  title: 'Database', route: RouteNames. ),
          // SidebarItem(  title: 'Side Menus', route: RouteNames. ),
        ],
      ),
      SidebarItem(
        title: 'App Settings',
        icon: Icons.settings,
        route: RouteNames.appSettingsPage,
        subItems: [
          SidebarItem(title: 'Users', route: RouteNames.appSettingsUsersPage),
          // SidebarItem(title: 'Sales Reps', route: '/admin2'),
          // SidebarItem(title: 'Vendors', route: '/admin2'),
          // SidebarItem(title: 'Deleted Projects', route: '/admin2'),
          // SidebarItem(title: 'Dropdowns', route: '/admin2'),
          // SidebarItem(title: 'Notifications Management', route: '/admin2'),
        ],
      ),
      SidebarItem(
        title: 'Customers',
        icon: Icons.group,
        subItems: [
          SidebarItem(title: 'All Customers', route: RouteNames.customersPage),
        ],
      ),
      SidebarItem(
        title: 'Production',
        icon: Icons.account_tree,
        subItems: [
          SidebarItem(
            title: 'Production Dashboard',
            route: RouteNames.productionPage,
          ),
          SidebarItem(title: 'Manage Products', route: '/production/products'),
        ],
      ),
      SidebarItem(
        title: 'Events',
        icon: Icons.event,
        subItems: [
          SidebarItem(title: 'Upcoming Events', route: RouteNames.eventsPage),
          SidebarItem(title: 'Create Event', route: '/events/create'),
        ],
      ),
      SidebarItem(
        title: 'Reports',
        icon: Icons.insert_chart_outlined,
        route: RouteNames.reportsPage,
        subItems: [
          SidebarItem(title: 'All', route: '/admin1'),
          SidebarItem(title: 'Autoplay', route: '/admin2'),
        ],
      ),
      SidebarItem(
        title: 'TroubleShooting',
        icon: Icons.build,
        route: RouteNames.troubleShootingPage,
        subItems: [
          SidebarItem(title: 'All', route: '/admin1'),
          SidebarItem(title: 'Autoplay', route: '/admin2'),
        ],
      ),
      SidebarItem(
        title: 'Help',
        icon: Icons.help_outline,
        route: RouteNames.helpPage,
        subItems: [
          SidebarItem(title: 'All', route: '/admin1'),
          SidebarItem(title: 'Autoplay', route: '/admin2'),
        ],
      ),
      SidebarItem(
        title: 'My Profile',
        icon: Icons.account_box,
        route: RouteNames.myProfilePage,
        subItems: [
          SidebarItem(title: 'All', route: '/admin1'),
          SidebarItem(title: 'Autoplay', route: '/admin2'),
        ],
      ),
      SidebarItem(
        title: 'About',
        icon: Icons.info_outline,
        route: RouteNames.aboutPage,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(onPressed: toggleSidebar, icon: Icon(Icons.sort)),
        Container(
          width: sidebarWidth,
          height: MediaQuery.of(context).size.height * 0.8,
          color: AppColors.royalBlue.withValues(alpha: .05),
          padding: const EdgeInsets.all(16),
          child: ListView(
            children:
                menuItems.map((item) {
                  final isSelected = currentRoute == item.route;
                  final isExpanded = expandedItem == item.title;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuItem(
                        context: context,
                        icon: item.icon,
                        title: item.title,
                        selected: isSelected || isExpanded,
                        hasSubItems: item.subItems != null,
                        onTap: () {
                          handleMenuTap(true);
                          if (item.subItems != null) {
                            setState(() {
                              expandedItem =
                                  expandedItem == item.title
                                      ? null
                                      : item.title;
                            });
                          }

                          // Navigate only if item has a direct route and no subitems, OR is the "Home" item
                          if (item.subItems == null || item.title == 'Home') {
                            if (item.route != null) {
                              context.goNamed(item.route!);
                            }
                          }
                        },

                        //   onTap: () {
                        //     context.goNamed(RouteNames.homeDashboardPage);
                        //     handleMenuTap(true);
                        //     if (item.subItems != null) {
                        //       setState(() {
                        //         expandedItem =
                        //             expandedItem == item.title
                        //                 ? null
                        //                 : item.title;
                        //       });
                        //     } else {
                        //       context.goNamed(item.route!);
                        //     }
                        //   },
                      ),
                      if (item.subItems != null && isExpanded)
                        ...item.subItems!.map((subItem) {
                          final subSelected = currentRoute == subItem.route;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: _buildSubMenuItem(
                              context: context,
                              icon: Icons.circle,
                              title: subItem.title,
                              selected: subSelected,
                              onTap: () {
                                handleMenuTap(true);
                                context.goNamed(subItem.route!);
                              },
                            ),
                          );
                        }),
                    ],
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool selected,
    bool hasSubItems = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.secondaryGreen : AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: selected ? AppColors.white : AppColors.darkGreenIcon,
                ),
                const SizedBox(width: 10),
                if (sidebarWidth == 250)
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color:
                            selected
                                ? AppColors.white
                                : AppColors.darkGreenIcon,
                        fontSize: 16,
                      ),
                    ),
                  ),
                if (hasSubItems)
                  Icon(
                    expandedItem == title
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: selected ? AppColors.white : AppColors.darkGreenIcon,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSubMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool selected,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.secondaryGreen : AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 8,
                  color: selected ? AppColors.white : AppColors.darkGreenIcon,
                ),
                const SizedBox(width: 10),
                if (sidebarWidth == 250)
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color:
                            selected
                                ? AppColors.white
                                : AppColors.darkGreenIcon,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class SidebarItem {
  final String title;
  final IconData icon;
  final String? route;
  final List<SidebarItem>? subItems;

  SidebarItem({
    required this.title,
    this.icon = Icons.circle,
    this.route,
    this.subItems,
  });
}
