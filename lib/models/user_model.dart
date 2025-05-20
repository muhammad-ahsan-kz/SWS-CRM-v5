class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String department;
  final String status;
  final String phone;
  final String secondaryRole;
  final List<String> vendors;
  final List<String> troubleShooting;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.department,
    required this.status,
    required this.phone,
    required this.secondaryRole,
    required this.vendors,
    required this.troubleShooting,
  });

  // Factory constructor to create a UserModel from a Map (e.g., Firestore or JSON)
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      department: map['department'] ?? '',
      status: map['status'] ?? '',
      phone: map['phone'] ?? '',
      secondaryRole: map['secondaryRole'] ?? '',
      vendors: List<String>.from(map['vendors'] ?? []),
      troubleShooting: List<String>.from(map['troubleShooting'] ?? []),
    );
  }

  // Method to convert a UserModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'department': department,
      'status': status,
      'phone': phone,
      'secondaryRole': secondaryRole,
      'vendors': vendors,
      'troubleShooting': troubleShooting,
    };
  }
}
