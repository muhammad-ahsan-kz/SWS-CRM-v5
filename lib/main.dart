import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sws_crm_v5/firebase_options.dart';
import 'package:sws_crm_v5/utils/routes/routes_config.dart';
import 'package:sws_crm_v5/view%20models/App%20Settings/app_settings_user_page_view_model.dart';
import 'package:sws_crm_v5/view%20models/Customer/customer_dashboard_page_view_model.dart';
import 'package:sws_crm_v5/view%20models/Customer/customers_page_view_model.dart';
import 'package:sws_crm_v5/view%20models/super_admin_drop_down_page_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomersPageViewModel()),
        ChangeNotifierProvider(create: (_) => CustomerDashboardPageViewModel()),
        ChangeNotifierProvider(create: (_) => AppSettingsUserPageViewModel()),
        ChangeNotifierProvider(
          create: (_) => SuperAdminDropDownPageViewModel(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyAppRouter().router,
        // theme: ThemeData(
        //   primaryColor: AppColors.primaryGreen,
        //   colorScheme: ColorScheme.light(
        //     // primary: AppColors.primaryGreen,
        //     // secondary: AppColors.secondaryGreen,
        //     surface: Colors.white,
        //   ),
        // ),
      ),
    );
  }
}
