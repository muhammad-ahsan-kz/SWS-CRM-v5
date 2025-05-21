import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sws_crm_v5/models/customers_list_model.dart';
import 'package:sws_crm_v5/utils/firestore_variables.dart';
import 'package:sws_crm_v5/widgets/popup_message_widget.dart';

class CustomersPageViewModel with ChangeNotifier {
  // Add new customer
  Future<void> addCustomer({
    required BuildContext parentContext,
    required BuildContext dialogBoxContext,
    required Map<String, dynamic> customerDetails,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection(FirestoreVariables.customersCollection)
          .add(customerDetails);
      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Customer Successfully Added',
        type: NotificationType.success,
      );
    } catch (error) {
      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Error Adding Customer',
        type: NotificationType.error,
      );
    }
  }

  // Fetch customers list
  Stream<List<Map<String, dynamic>>> fetchCustomersList() {
    return FirebaseFirestore.instance
        .collection(FirestoreVariables.customersCollection)
        .snapshots()
        .map((querySnapshot) {
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
