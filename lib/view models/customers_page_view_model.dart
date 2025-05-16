import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sws_crm_v5/models/customers_list_model.dart';

class CustomersPageViewModel with ChangeNotifier {
  // Add new customer
  Future<void> addCustomer({
    required Map<String, dynamic> customerDetails,
  }) async {
    try {
      FirebaseFirestore.instance.collection('customers').add(customerDetails);
      debugPrint('Success');
    } catch (error) {
      debugPrint('Failed');
    }
  }

  Stream<List<Map<String, dynamic>>> fetchCustomersList() {
    return FirebaseFirestore.instance.collection('customers').snapshots().map((
      querySnapshot,
    ) {
      return querySnapshot.docs.map((doc) {
        final data = CustomersListModel.fromJson(doc);

        return {
          'id': data.id,
          'fullName': '${data.firstName} ${data.lastName}',
          'phone': data.phone,
          'mobile': data.mobile,
          'email': data.email,
          'address': data.address,
        };
      }).toList();
    });
  }
}
