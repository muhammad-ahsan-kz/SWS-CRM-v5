class UserModel {
  final String id;
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
    required this.id,
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
  factory UserModel.fromJson({
    required Map<String, dynamic> data,
    required String userId,
  }) {
    return UserModel(
      id: userId,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      department: data['department'] ?? '',
      status: data['status'] ?? '',
      phone: data['phone'] ?? '',
      secondaryRole: data['secondaryRole'] ?? '',
      vendors: List<String>.from(data['vendors'] ?? []),
      troubleShooting: List<String>.from(data['troubleShooting'] ?? []),
    );
  }

  // Method to convert a UserModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
