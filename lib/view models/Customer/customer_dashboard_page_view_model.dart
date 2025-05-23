import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sws_crm_v5/models/customers_list_model.dart';
import 'package:sws_crm_v5/models/dropdown_model.dart';
import 'package:sws_crm_v5/models/project_model.dart';
import 'package:sws_crm_v5/utils/firestore_variables.dart';
import 'package:sws_crm_v5/widgets/popup_message_widget.dart';

class CustomerDashboardPageViewModel with ChangeNotifier {
  List<DropdownModel> allDropdowns = [];

  CustomersListModel? customerDetails;

  String selectedContinueValue = 'No';
  List<String> continueValuesList = ['No', 'Yes'];

  String selectedCustomerNameValue = 'Barbara Darling';
  List<String> customerNameValuesList = ['Barbara Darling', 'Mark Fisher'];

  String? selectedBranchNameValue;
  List<String> branchNameValuesList = [];

  String? selectedVendorValue;
  List<String> vendorValuesList = [];

  String selectedSalesRepValue = 'Barbara Darling';
  List<String> salesRepValuesList = ['Barbara Darling', 'Mark Fisher'];

  String selectedProjectTypeValue = 'Barbara Darling';
  List<String> projectTypeValuesList = ['Barbara Darling', 'Mark Fisher'];

  String selectedExistingSystemValue = 'No';
  List<String> existingSystemValuesList = ['No', 'Yes'];

  String selectedProjectManagerValue = 'Barbara Darling';
  List<String> projectManagerValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedProjectManagerVAValue = 'Barbara Darling';
  List<String> projectManagerVAValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedSecondaryProjectManagerValue = 'Barbara Darling';
  List<String> secondaryProjectManagerValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedSecondaryProjectManagerVAValue = 'Barbara Darling';
  List<String> secondaryProjectManagerVAValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedFinanceManagerValue = 'Barbara Darling';
  List<String> financeManagerValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedFinanceManagerVAValue = 'Barbara Darling';
  List<String> financeManagerVAValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedEngineerValue = 'Barbara Darling';
  List<String> engineerValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedFireApprovalNeededValue = 'Barbara Darling';
  List<String> fireApprovalNeededValuesList = [
    'Barbara Darling',
    'Mark Fisher',
  ];
  String selectedFireInspectionValue = 'Barbara Darling';
  List<String> fireInspectionValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedPermitTechValue = 'Barbara Darling';
  List<String> projectPermitTechValuesList = ['Barbara Darling', 'Mark Fisher'];
  String selectedUtilityValue = 'Barbara Darling';
  List<String> utilityValuesList = ['Barbara Darling', 'Mark Fisher'];

  String selectedJobStatusValue = 'Inprogress';
  List<String> jobStatusValuesList = ['Inprogress', 'Completed'];
  String selectedProjectStatusValue = 'Canceled';
  List<String> projectStatusValuesList = [
    'Canceled',
    'Inprogress',
    'Completed',
  ];
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
    required String customerId,
  }) {
    try {
      Query querySnapshot = FirebaseFirestore.instance
          .collection(FirestoreVariables.projectsCollection)
          .where('customerId', isEqualTo: customerId);

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

  // // Fetch customers list
  // Future<void> fetchCustomersList({required BuildContext parentContext}) async {
  //   try {
  //     final fetchedList =
  //         await FirebaseFirestore.instance
  //             .collection(FirestoreVariables.customersCollection)
  //             .get();
  //     // Full List
  //     customerNameValuesList =
  //         fetchedList.docs.map((doc) {
  //           final data = CustomersListModel.fromJson(doc);
  //           return '${data.firstName} ${data.lastName}';
  //         }).toList();

  //     // First Item
  //     if (fetchedList.docs.isNotEmpty) {
  //       final firstCustomer = CustomersListModel.fromJson(
  //         fetchedList.docs.first,
  //       );
  //       selectedCustomerNameValue = firstCustomer.firstName;
  //     } else {
  //       selectedCustomerNameValue = 'Select a Customer';
  //     }
  //     notifyListeners();
  //   } catch (error) {
  //     selectedCustomerNameValue = 'Select a Customer';
  //     customerNameValuesList = [];
  //     notifyListeners();
  //     debugPrint(error.toString());
  //   }
  // }

  Future<void> fetchAllDropdowns(BuildContext context) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection(FirestoreVariables.dropdownsCollection)
              .get();

      allDropdowns =
          snapshot.docs.map((doc) {
            return DropdownModel.fromJson(document: doc.data(), docId: doc.id);
          }).toList();

      // Simple assignments for each type
      assignDropdown(
        type: 'Branch',
        setList: (list) => branchNameValuesList = list,
        setSelected: (value) => selectedBranchNameValue = value,
      );

      assignDropdown(
        type: 'Vendor',
        setList: (list) => vendorValuesList = list,
        setSelected: (value) => selectedVendorValue = value,
      );

      notifyListeners();
    } catch (e) {
      NotificationService.show(
        context,
        message: 'Error loading dropdowns',
        type: NotificationType.error,
      );
    }
  }

  // Helper to get dropdowns list by type
  List<String> getDropdowns(String type) {
    final found = allDropdowns.firstWhere(
      (d) => d.type == type,
      orElse: () => DropdownModel(id: '', type: type, dropdowns: []),
    );
    return found.dropdowns;
  }

  void assignDropdown({
    required String type,
    required Function(List<String>) setList,
    required Function(String?) setSelected,
  }) {
    final items = getDropdowns(type);
    setList(items);
    setSelected(items.isNotEmpty ? items.first : null);
  }

  // Fetch customer details
  Future<void> fetchSpecificCustomerDetails({
    required String customerId,
  }) async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance
              .collection(FirestoreVariables.customersCollection)
              .doc(customerId)
              .get();

      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        customerDetails = CustomersListModel.fromJson(documentSnapshot);
      } else {
        debugPrint('No customer found for ID: $customerId');
      }
    } catch (error) {
      debugPrint('Error fetching customer details: $error');
    }
  }
}
