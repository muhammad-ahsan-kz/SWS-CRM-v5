import 'package:flutter/material.dart';
import 'package:sws_crm_v5/widgets/home_card_widget.dart';

class HomeEventNotificationsPage extends StatelessWidget {
  const HomeEventNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: HomeCardWidget(
        context: context,
        title: 'Event Notifications',
        containerHeight: screenHeight,
        containerWidth: screenWidth,
        itemsList: [],
      ),
    );
  }
}
