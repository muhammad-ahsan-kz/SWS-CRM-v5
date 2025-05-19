import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  Future<void> logout(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    context.goNamed(RouteNames.loginPage);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.greenBorder),
                  ),
                  child: Icon(
                    Icons.app_registration,
                    color: AppColors.secondaryGreen,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'SWS CRM v5',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreenText,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _buildSearchBar(),
                SizedBox(width: 15),
                _buildProfilePhoto(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      height: 40,
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGreen.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.greenBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.darkGreenIcon),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              // controller: searchController,
              // onSubmitted: onSearch,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: AppColors.darkGreenText,
                  fontSize: 12,
                ),
                isCollapsed: true,
                border: InputBorder.none,
              ),
              style: TextStyle(color: AppColors.darkGreenText, fontSize: 12),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear, color: AppColors.darkGreenIcon),
            onPressed: () {},
            tooltip: 'Clear',
          ),
        ],
      ),
    );
  }

  // Right Profile Photo
  Widget _buildProfilePhoto(BuildContext context) {
    final String email = 'ahsanshahidkhanzada@gmail.com';
    return // Right Side: PopupMenuButton
    PopupMenuButton<String>(
      borderRadius: BorderRadius.circular(50),
      onSelected: (value) {
        // Handle menu selection
        if (value == 'profile') {
          // print('Go to Profile');
          // Navigate to profile screen or show a dialog
        } else if (value == 'logout') {
          logout(context);
          // print('Logging out...');
          // Handle logout logic
        }
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.background,
                    child: Text(
                      email.isNotEmpty ? email[0].toUpperCase() : '?',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Text(email, overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.background,
                    child: Icon(Icons.logout, size: 15, color: AppColors.white),
                  ),
                  SizedBox(width: 10),
                  Text('Logout'),
                ],
              ),
            ),
          ],
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,

          border: Border.all(color: AppColors.greenBorder),
        ),
        child: Icon(Icons.person, color: AppColors.darkGreenIcon),
      ),
    );
  }
}
