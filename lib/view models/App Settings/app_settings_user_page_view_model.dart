import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:sws_crm_v5/models/add_user_model.dart';
import 'package:sws_crm_v5/models/user_model.dart';
import 'package:sws_crm_v5/utils/firestore_variables.dart';
import 'package:sws_crm_v5/widgets/popup_message_widget.dart';

class AppSettingsUserPageViewModel with ChangeNotifier {
  List<UserModel> allUsersList = [];
  List<UserModel> filteredUsersList = [];
  String selectedRoleValue = 'Finance Manager';
  String selectedStatusValue = 'Active';
  List<String> roleValuesList = [
    'Finance Manager',
    'Production Manager',
    'Super Admin',
  ];
  List<String> statusValuesList = ['Active', 'Inactive'];
  Future<void> createUser({
    required BuildContext context,
    required BuildContext dialogBoxContext,
    required String firstName,
    required String lastName,
    required String email,
    required String role,
    required String department,
    required String status,
  }) async {
    try {
      final AddUserModel newUserData = AddUserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        department: department,
        status: status,
        phone: '',
        secondaryRole: '',
        vendors: [],
        troubleShooting: [],
      );
      if (await checkIfEmailAlreadyExists(newEmail: email)) {
        NotificationService.show(
          context,
          message: 'This Email Already Exists',
          type: NotificationType.error,
        );
        Navigator.of(dialogBoxContext).pop();
      } else {
        await FirebaseFirestore.instance
            .collection(FirestoreVariables.usersCollection)
            .add(newUserData.toJson());
        Navigator.of(dialogBoxContext).pop();
        NotificationService.show(
          context,
          message: 'User Successfully Created',
          type: NotificationType.success,
        );
      }
    } catch (error) {
      NotificationService.show(
        context,
        message: 'Error Creating User',
        type: NotificationType.error,
      );
    }
  }

  Future<bool> checkIfEmailAlreadyExists({required String newEmail}) async {
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection(FirestoreVariables.usersCollection)
            .where('email', isEqualTo: newEmail)
            .limit(1)
            .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Fetch all users list
  Stream<List<UserModel>> fetchUsersList({
    required String roleFilter,
    required BuildContext context,
  }) {
    try {
      Query querySnapshot = FirebaseFirestore.instance.collection(
        FirestoreVariables.usersCollection,
      );

      if (roleFilter != 'All') {
        querySnapshot = querySnapshot.where('role', isEqualTo: roleFilter);
      }

      final usersList = querySnapshot.snapshots().map(
        (fetchedList) =>
            fetchedList.docs
                .map(
                  (doc) => UserModel.fromJson(
                    data: doc.data() as Map<String, dynamic>,
                    userId: doc.id,
                  ),
                )
                .toList(),
      );
      return usersList;
    } catch (error) {
      NotificationService.show(
        context,
        message: 'Error Fetching Users List',
        type: NotificationType.error,
      );
      return const Stream.empty();
    }
  }

  // Edit customer
  Future<void> editUser({
    required BuildContext parentContext,
    required BuildContext dialogBoxContext,
    required String userId,
    required Map<String, dynamic> userDetails,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirestoreVariables.usersCollection)
          .doc(userId)
          .update(userDetails);

      Navigator.of(dialogBoxContext).pop();

      NotificationService.show(
        parentContext,
        message: 'User Successfully Updated',
        type: NotificationType.success,
      );
    } catch (error) {
      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Error Updating User',
        type: NotificationType.error,
      );
    }
  }

  // Delete user
  Future<void> deleteUser({
    required BuildContext parentContext,
    required BuildContext dialogBoxContext,
    required String userId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirestoreVariables.usersCollection)
          .doc(userId)
          .delete();
      Navigator.of(dialogBoxContext).pop();

      NotificationService.show(
        parentContext,
        message: 'User Successfully Deleted',
        type: NotificationType.success,
      );
    } catch (error) {
      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Error Deleting User',
        type: NotificationType.error,
      );
    }
  }

  // Filter users list
  void filterUsersList({required String role}) {}
}
