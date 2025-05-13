import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.path;

    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      color: AppColors.royalBlue.withValues(alpha: .1),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          _buildMenuItem(
            icon: Icons.home,
            title: 'Home',
            context: context,
            pageName: RouteNames.homeDashboardPage,
            selected: currentRoute == RouteNames.homeDashboardPage,
          ),
          _buildMenuItem(
            icon: Icons.admin_panel_settings,
            title: 'Super Admin',
            context: context,
            pageName: RouteNames.superAdminPage,
            selected: currentRoute == RouteNames.superAdminPage,
          ),
          _buildMenuItem(
            icon: Icons.settings,
            title: 'App Settings',
            context: context,
            pageName: RouteNames.appSettingsPage,
            selected: currentRoute == RouteNames.appSettingsPage,
          ),
          _buildMenuItem(
            icon: Icons.group,
            title: 'Customers',
            context: context,
            pageName: RouteNames.customersPage,
            selected: currentRoute == RouteNames.customersPage,
          ),
          _buildMenuItem(
            icon: Icons.account_tree,
            title: 'Production',
            context: context,
            pageName: RouteNames.productionPage,
            selected: currentRoute == RouteNames.productionPage,
          ),
          _buildMenuItem(
            icon: Icons.event,
            title: 'Events',
            context: context,
            pageName: RouteNames.eventsPage,
            selected: currentRoute == RouteNames.eventsPage,
          ),
          _buildMenuItem(
            icon: Icons.insert_chart_outlined,
            title: 'Reports',
            context: context,
            pageName: RouteNames.reportsPage,
            selected: currentRoute == RouteNames.reportsPage,
          ),
          _buildMenuItem(
            icon: Icons.build,
            title: 'TroubleShooting',
            context: context,
            pageName: RouteNames.troubleShootingPage,
            selected: currentRoute == RouteNames.troubleShootingPage,
          ),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Help',
            context: context,
            pageName: RouteNames.helpPage,
            selected: currentRoute == RouteNames.helpPage,
          ),
          _buildMenuItem(
            icon: Icons.account_box,
            title: 'My Profile',
            context: context,
            pageName: RouteNames.myProfilePage,
            selected: currentRoute == RouteNames.myProfilePage,
          ),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: 'About',
            context: context,
            pageName: RouteNames.aboutPage,
            selected: currentRoute == RouteNames.aboutPage,
          ),
        ],
      ),
    );
  }

  // Menu Item
  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String pageName,
    required bool selected,
  }) {
    return MouseRegion(
      onEnter: (event) {},
      onExit: (event) {},
      onHover: (event) {},
      child: InkWell(
        onTap: () => GoRouter.of(context).go(pageName),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.secondaryGreen : AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? AppColors.white : AppColors.darkGreenIcon,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: selected ? AppColors.white : AppColors.darkGreenIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
