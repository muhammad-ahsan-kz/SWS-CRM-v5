import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sws_crm_v5/models/customers_list_model.dart';
import 'package:sws_crm_v5/models/project_model.dart';
import 'package:sws_crm_v5/utils/firestore_variables.dart';
import 'package:sws_crm_v5/widgets/popup_message_widget.dart';

class CustomerDashboardPageViewModel with ChangeNotifier {
  String selectedContinueValue = 'No';
  final List<String> continueValuesList = ['No', 'Yes'];

  String selectedCustomerNameValue = 'Barbara Darling';
  final List<String> customerNameValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedBranchNameValue = 'Barbara Darling';
  final List<String> branchNameValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedVendorValue = 'Barbara Darling';
  final List<String> vendorValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedSalesRepValue = 'Barbara Darling';
  final List<String> salesRepValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedProjectTypeValue = 'Barbara Darling';
  final List<String> projectTypeValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedExistingSystemValue = 'Barbara Darling';
  final List<String> existingSystemValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedProjectManagerValue = 'Barbara Darling';
  final List<String> projectManagerValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedProjectManagerVAValue = 'Barbara Darling';
  final List<String> projectManagerVAValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedSecondaryProjectManagerValue = 'Barbara Darling';
  final List<String> secondaryProjectManagerValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedSecondaryProjectManagerVAValue = 'Barbara Darling';
  final List<String> secondaryProjectManagerVAValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedFinanceManagerValue = 'Barbara Darling';
  final List<String> financeManagerValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedFinanceManagerVAValue = 'Barbara Darling';
  final List<String> financeManagerVAValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedEngineerValue = 'Barbara Darling';
  final List<String> engineerValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedFireApprovalNeededValue = 'Barbara Darling';
  final List<String> fireApprovalNeededValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedFireInspectionValue = 'Barbara Darling';
  final List<String> fireInspectionValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedPermitTechValue = 'Barbara Darling';
  final List<String> projectPermitTechValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedUtilityValue = 'Barbara Darling';
  final List<String> utilityValuesList = ['Barbara Darling', 'Mark Fisher'];
  // Add new project
  Future<void> addCustomerProject({
    required BuildContext parentContext,
    required BuildContext dialogBoxContext,
    required Map<String, dynamic> projectDetails,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection(FirestoreVariables.projectsCollection)
          .add(projectDetails);
      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Project Successfully Added',
        type: NotificationType.success,
      );
    } catch (error) {
      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Error Adding Project',
        type: NotificationType.error,
      );
    }
  }

  // Fetch customers list
  // Stream<List<Map<String, dynamic>>> fetchCustomersList() {
  //   return FirebaseFirestore.instance.collection('customers').snapshots().map((
  //     querySnapshot,
  //   ) {
  //     return querySnapshot.docs.map((doc) {
  //       final data = CustomersListModel.fromJson(doc);

  //       return {
  //         'id': data.id,
  //         'firstName': '${data.firstName} ${data.lastName}',
  //         'Phone': data.phone,
  //         'mobile': data.mobile,
  //         'email': data.email,
  //         'address': data.address,
  //       };
  //     }).toList();
  //   });
  // }

  // Fetch customer details
  Future<Map<String, dynamic>?> fetchCustomerDetails({
    required String customerId,
  }) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection(FirestoreVariables.customersCollection)
              .doc(customerId)
              .get();

      if (docSnapshot.exists) {
        final data = CustomersListModel.fromJson(docSnapshot);
        return data.toJson();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching customer: $e');
      return null;
    }
  }

  // Fetch projects list
  Stream<List<ProjectModel>> fetchProjectsList({
    required BuildContext parentContext,
  }) {
    try {
      Query querySnapshot = FirebaseFirestore.instance.collection(
        FirestoreVariables.projectsCollection,
      );

      final projectsList = querySnapshot.snapshots().map(
        (fetchedList) =>
            fetchedList.docs
                .map(
                  (doc) => ProjectModel.fromJson(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ),
                )
                .toList(),
      );
      return projectsList;
    } catch (error) {
      NotificationService.show(
        parentContext,
        message: 'Error Fetching Projects List',
        type: NotificationType.error,
      );
      return const Stream.empty();
    }
  }

  // Update dropdown value
  void updateDropDownValue({
    required String selectedValue,
    required String newValue,
  }) {
    selectedValue = newValue;
    notifyListeners();
  }
}
