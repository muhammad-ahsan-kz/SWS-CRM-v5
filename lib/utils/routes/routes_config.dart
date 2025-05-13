import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';
import 'package:sws_crm_v5/views/about_page.dart';
import 'package:sws_crm_v5/views/app_settings_page.dart';
import 'package:sws_crm_v5/views/customers_page.dart';
import 'package:sws_crm_v5/views/error_Page.dart';
import 'package:sws_crm_v5/views/events_page.dart';
import 'package:sws_crm_v5/views/help_page.dart';
import 'package:sws_crm_v5/views/home_dashboard_page.dart';
import 'package:sws_crm_v5/views/home_page.dart';
import 'package:sws_crm_v5/views/my_profile_page.dart';
import 'package:sws_crm_v5/views/production_page.dart';
import 'package:sws_crm_v5/views/reports_page.dart';
import 'package:sws_crm_v5/views/super_admin_page.dart';
import 'package:sws_crm_v5/views/trouble_shooting_page.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    initialLocation: RouteNames.homeDashboardPage,
    routes: [
      ShellRoute(
        builder: (context, state, child) => HomePage(child: child),
        routes: [
          GoRoute(
            name: RouteNames.homeDashboardPage,
            path: RouteNames.homeDashboardPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeDashboardPage());
            },
          ),
          GoRoute(
            name: RouteNames.superAdminPage,
            path: RouteNames.superAdminPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: SuperAdminPage());
            },
          ),
          GoRoute(
            name: RouteNames.appSettingsPage,
            path: RouteNames.appSettingsPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: AppSettingsPage());
            },
          ),
          GoRoute(
            name: RouteNames.customersPage,
            path: RouteNames.customersPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: CustomersPage());
            },
          ),
          GoRoute(
            name: RouteNames.productionPage,
            path: RouteNames.productionPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: ProductionPage());
            },
          ),
          GoRoute(
            name: RouteNames.eventsPage,
            path: RouteNames.eventsPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: EventsPage());
            },
          ),
          GoRoute(
            name: RouteNames.reportsPage,
            path: RouteNames.reportsPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: ReportsPage());
            },
          ),
          GoRoute(
            name: RouteNames.troubleShootingPage,
            path: RouteNames.troubleShootingPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: TroubleShootingPage());
            },
          ),
          GoRoute(
            name: RouteNames.helpPage,
            path: RouteNames.helpPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: HelpPage());
            },
          ),
          GoRoute(
            name: RouteNames.myProfilePage,
            path: RouteNames.myProfilePage,
            pageBuilder: (context, state) {
              return MaterialPage(child: MyProfilePage());
            },
          ),
          GoRoute(
            name: RouteNames.aboutPage,
            path: RouteNames.aboutPage,
            pageBuilder: (context, state) {
              return MaterialPage(child: AboutPage());
            },
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.homePage,
        path: RouteNames.homePage,
        pageBuilder: (context, state) {
          return MaterialPage(child: HomePage(child: HomeDashboardPage()));
        },
      ),
    ],

    errorPageBuilder: (context, state) {
      return MaterialPage(child: ErrorPage());
    },
  );
}
