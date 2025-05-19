import 'package:flutter/material.dart';

class SuperAdminDropdownsPage extends StatelessWidget {
  const SuperAdminDropdownsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(body: Text('DropDowns'));
  }
}
