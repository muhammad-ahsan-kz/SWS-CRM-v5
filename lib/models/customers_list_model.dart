import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersListModel {
  final String id;
  final String firstName;
  final String lastName;
  final String secondaryName;
  final String secondaryLastName;
  final String phone;
  final String mobile;
  final String address;
  final String unit;
  final String email;

  CustomersListModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.secondaryName,
    required this.secondaryLastName,
    required this.phone,
    required this.mobile,
    required this.address,
    required this.unit,
    required this.email,
  });

  // Deserialize from Firestore JSON
  factory CustomersListModel.fromJson(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return CustomersListModel(
      id: doc.id,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      secondaryName: json['secondaryName'] ?? '',
      secondaryLastName: json['secondaryLastName'] ?? '',
      phone: json['phone'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      unit: json['unit'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Serialize to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'secondaryName': secondaryName,
      'secondaryLastName': secondaryLastName,
      'phone': phone,
      'mobile': mobile,
      'address': address,
      'unit': unit,
      'email': email,
    };
  }
}
