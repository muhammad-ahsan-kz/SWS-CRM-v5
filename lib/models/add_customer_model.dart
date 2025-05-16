class AddCustomerModel {
  final String firstName;
  final String lastName;
  final String secondaryName;
  final String secondaryLastName;
  final String phone;
  final String mobile;
  final String address;
  final String unit;
  final String email;

  AddCustomerModel({
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
  factory AddCustomerModel.fromJson(Map<String, dynamic> json) {
    return AddCustomerModel(
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
      'firstName': firstName,
      'lastName': lastName,
      'secondaryName': secondaryName,
      'secondaryLastName': secondaryLastName,
      'phone': phone,
      'mobile': mobile,
      'address': address,
      'unit': unit,
      // if (unit != null) 'unit': unit,
      'email': email,
    };
  }
}
