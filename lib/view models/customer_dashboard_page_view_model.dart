import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sws_crm_v5/models/customers_list_model.dart';

class CustomerDashboardPageViewModel with ChangeNotifier {
  // Add new customer
  Future<void> addCustomerProject({
    required Map<String, dynamic> projectDetails,
  }) async {
    try {
      FirebaseFirestore.instance.collection('projects').add(projectDetails);
      debugPrint('Successfully added new project');
    } catch (error) {
      debugPrint('Failed to add new project');
    }
  }

  // Fetch customers list
  Stream<List<Map<String, dynamic>>> fetchCustomersList() {
    return FirebaseFirestore.instance.collection('customers').snapshots().map((
      querySnapshot,
    ) {
      return querySnapshot.docs.map((doc) {
        final data = CustomersListModel.fromJson(doc);

        return {
          'id': data.id,
          'firstName': '${data.firstName} ${data.lastName}',
          'Phone': data.phone,
          'mobile': data.mobile,
          'email': data.email,
          'address': data.address,
        };
      }).toList();
    });
  }

  Future<Map<String, dynamic>?> fetchCustomerDetails({
    required String customerId,
  }) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection('customers')
              .doc(customerId)
              .get();

      if (docSnapshot.exists) {
        final data = CustomersListModel.fromJson(docSnapshot);
        return data.toJson();
        // return {
        //   'id': data.id,
        //   'fullName': '${data.firstName} ${data.lastName}',
        //   'address': data.address,
        //   'phone': data.phone,
        //   'email': data.email,
        // };
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching customer: $e');
      return null;
    }
  }
}
