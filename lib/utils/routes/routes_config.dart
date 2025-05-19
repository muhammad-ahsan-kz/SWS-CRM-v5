import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/models/customers_list_model.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';
import 'package:sws_crm_v5/views/about_page.dart';
import 'package:sws_crm_v5/views/app_settings_page.dart';
import 'package:sws_crm_v5/views/customer_dashboard_page.dart';
import 'package:sws_crm_v5/views/customer_project_details_page.dart';
import 'package:sws_crm_v5/views/customers_page.dart';
import 'package:sws_crm_v5/views/error_Page.dart';
import 'package:sws_crm_v5/views/events_page.dart';
import 'package:sws_crm_v5/views/help_page.dart';
import 'package:sws_crm_v5/views/home_dashboard_page.dart';
import 'package:sws_crm_v5/views/home_event_notifications_page.dart';
import 'package:sws_crm_v5/views/home_favourites_menu_page.dart';
import 'package:sws_crm_v5/views/home_favourites_projects_page.dart';
import 'package:sws_crm_v5/views/home_message_box_page.dart';
import 'package:sws_crm_v5/views/home_notification_page.dart';
import 'package:sws_crm_v5/views/home_page.dart';
import 'package:sws_crm_v5/views/home_tasks_page.dart';
import 'package:sws_crm_v5/views/login_page.dart';
import 'package:sws_crm_v5/views/my_profile_page.dart';
import 'package:sws_crm_v5/views/production_page.dart';
import 'package:sws_crm_v5/views/reports_page.dart';
import 'package:sws_crm_v5/views/super_admin_dropdowns_page.dart';
import 'package:sws_crm_v5/views/super_admin_page.dart';
import 'package:sws_crm_v5/views/trouble_shooting_page.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      // Login screen
      GoRoute(
        name: RouteNames.loginPage,
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        name: RouteNames.homePage,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomePage(child: HomeDashboardPage()));
        },
      ),
      GoRoute(
        name: RouteNames.errorPage,
        path: '/error',
        pageBuilder: (context, state) {
          return MaterialPage(child: ErrorPage());
        },
      ),
      ShellRoute(
        builder: (context, state, child) => HomePage(child: child),
        routes: [
          // Home and its nested screens
          GoRoute(
            name: RouteNames.homeDashboardPage,
            path: '/dashboard',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeDashboardPage());
            },
          ),
          GoRoute(
            name: RouteNames.homeFavouritesMenuPage,
            path: '/favourites-menu',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeFavouritesMenuPage());
            },
          ),
          GoRoute(
            name: RouteNames.homeFavouriteProjectsPage,
            path: '/favourite-projects',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeFavouritesProjectsPage());
            },
          ),

          GoRoute(
            name: RouteNames.homeNotificationsPage,
            path: '/notifications',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeNotificationPage());
            },
          ),
          GoRoute(
            name: RouteNames.homeMessageBoxPage,
            path: '/message-box',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeMessageBoxPage());
            },
          ),
          GoRoute(
            name: RouteNames.homeEventNotificationsPage,
            path: '/event-notifications',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeEventNotificationsPage());
            },
          ),
          GoRoute(
            name: RouteNames.homeTasksPage,
            path: '/tasks',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomeTasksPage());
            },
          ),

          // Super Admin and its nested screens
          GoRoute(
            name: RouteNames.superAdminPage,
            path: '/super-admin',
            pageBuilder: (context, state) {
              return MaterialPage(child: SuperAdminPage());
            },
            routes: [
              GoRoute(
                name: RouteNames.superAdminDropdownsPage,
                path: '/super-admin-dropdowns',
                pageBuilder: (context, state) {
                  return MaterialPage(child: SuperAdminDropdownsPage());
                },
              ),
            ],
          ),

          // App Setting and its nested screens
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
          GoRoute(
            name: RouteNames.customerDashboardPage,
            path: RouteNames.customerDashboardPage,
            pageBuilder: (context, state) {
              final String customerId =
                  state.uri.queryParameters['customerId']!;
              return MaterialPage(
                child: CustomerDashboardPage(customerId: customerId),
              );
            },
          ),
          GoRoute(
            name: RouteNames.customerProjectDetailsPage,
            path: RouteNames.customerProjectDetailsPage,
            pageBuilder: (context, state) {
              final projectName = state.uri.queryParameters['projectName'];
              return MaterialPage(
                child: CustomerProjectDetailsPage(projectName: projectName!),
              );
            },
          ),
        ],
      ),
    ],

    errorPageBuilder: (context, state) {
      return MaterialPage(child: ErrorPage());
    },
  );
}
