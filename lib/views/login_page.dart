import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/utils/routes/route_names.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final googleProvider = GoogleAuthProvider();
      googleProvider.setCustomParameters({'prompt': 'select_account'});

      final userCredential = await FirebaseAuth.instance.signInWithPopup(
        googleProvider,
      );
      final user = userCredential.user;

      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Authentication failed.")));
        return;
      }

      final email = user.email!;
      final userDoc =
          await FirebaseFirestore.instance
              .collection('customers')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      if (userDoc.docs.isEmpty) {
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Access denied. Email not found in database."),
          ),
        );
        return;
      }

      context.goNamed(RouteNames.homePage);
    } catch (e) {
      debugPrint('Sign-in error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFB2DFDB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: screenWidth * 0.4,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome to SWS-CRM",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Secure CRM access via Google Workspace",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => signInWithGoogle(context),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greenBorder),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/images/googleLogo.png',
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreenText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sws_crm_v5/utils/app_colors.dart';
// import 'package:sws_crm_v5/utils/routes/route_names.dart';

// class LoginPage extends StatelessWidget {
//   // final Widget child;
//   const LoginPage({
//     super.key,
//     // required this.child
//   });
//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final googleProvider = GoogleAuthProvider();

//       // 👇 Force Google to prompt user to select an account every time
//       googleProvider.setCustomParameters({'prompt': 'select_account'});

//       final userCredential = await FirebaseAuth.instance.signInWithPopup(
//         googleProvider,
//       );
//       final user = userCredential.user;

//       if (user == null) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text("Authentication failed.")));
//         return;
//       }

//       // Check if email exists in Firestore
//       final email = user.email!;
//       final userDoc =
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .where('email', isEqualTo: email)
//               .limit(1)
//               .get();

//       if (userDoc.docs.isEmpty) {
//         await FirebaseAuth.instance.signOut();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Access denied. Email not found in database."),
//           ),
//         );
//         return;
//       }

//       // Navigate to home/dashboard
//       context.goNamed(RouteNames.homePage);
//     } catch (e) {
//       debugPrint('Sign-in error: $e');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: InkWell(
//               borderRadius: BorderRadius.circular(50),
//               onTap: () {
//                 signInWithGoogle(context);
//               },
//               child: Container(
//                 height: 50,
//                 width: screenWidth * 0.3,
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.greenBorder),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Signin with Google',
//                     style: TextStyle(color: AppColors.darkGreenText),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
