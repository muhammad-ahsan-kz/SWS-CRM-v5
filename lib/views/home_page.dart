import 'package:flutter/material.dart';
import 'package:sws_crm_v5/widgets/appbar_widget.dart';
import 'package:sws_crm_v5/widgets/sidebar_widget.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Appbar
          AppbarWidget(),

          // Sidebar
          Expanded(
            child: Row(
              children: [
                SidebarWidget(),

                // Content
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
