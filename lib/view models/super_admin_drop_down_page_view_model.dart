import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sws_crm_v5/models/dropdown_model.dart';
import 'package:sws_crm_v5/utils/firestore_variables.dart';
import 'package:sws_crm_v5/widgets/popup_message_widget.dart';

class SuperAdminDropDownPageViewModel with ChangeNotifier {
  List<String> dropdownsList = [];

  Future<void> addNewDropdown({
    required BuildContext parentContext,
    required BuildContext dialogBoxContext,
    required String dropdownName,
    required List<String> dropdownType,
  }) async {
    try {
      // if (dropdownName.isEmpty || dropdownType.isEmpty) {
      //   Navigator.of(dialogBoxContext).pop();
      //   NotificationService.show(
      //     parentContext,
      //     message: 'Dropdown or type list cannot be empty.',
      //     type: NotificationType.error,
      //   );
      //   return;
      // }

      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection(
        FirestoreVariables.dropdownsCollection,
      );

      for (String typeItem in dropdownType) {
        final query = await collection.where('type', isEqualTo: typeItem).get();

        if (query.docs.isNotEmpty) {
          // Type exists → add dropdown to its list
          final docRef = query.docs.first.reference;

          await docRef.update({
            'dropdowns': FieldValue.arrayUnion([dropdownName]),
          });
        } else {
          // Type doesn't exist → create new document
          await collection.add({
            'type': typeItem,
            'dropdowns': [dropdownName],
          });
        }
      }

      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Dropdown mapped successfully to types.',
        type: NotificationType.success,
      );
    } catch (error) {
      Navigator.of(dialogBoxContext).pop();
      NotificationService.show(
        parentContext,
        message: 'Error mapping dropdown to types.',
        type: NotificationType.error,
      );
    }
  }

  // Fetch dropdowns list
  Stream<List<DropdownModel>> fetchDropdownsList({
    required BuildContext parentContext,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection(FirestoreVariables.dropdownsCollection)
          .snapshots()
          .map((querySnapshot) {
            return querySnapshot.docs.map((doc) {
              final data = DropdownModel.fromJson(
                document: doc.data(),
                docId: doc.id,
              );

              return data;
            }).toList();
          });
    } catch (error) {
      NotificationService.show(
        parentContext,
        message: 'Error Fetching Dropdowns List',
        type: NotificationType.error,
      );
      return const Stream.empty();
    }
  }

  // Fetch all dropdowns list
  Future<void> fetchAllDropdownsList() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection(FirestoreVariables.dropdownsCollection)
              .get();

      // Extract and assign type fields
      dropdownsList =
          querySnapshot.docs
              .map((doc) => doc.data()['type']?.toString() ?? '')
              .where((type) => type.isNotEmpty)
              .toSet() // Remove duplicates if any
              .toList();

      notifyListeners(); // 🔄 Optional if using with dropdown UI updates
    } catch (error) {
      debugPrint('Error fetching dropdown types: $error');
    }
  }
}
