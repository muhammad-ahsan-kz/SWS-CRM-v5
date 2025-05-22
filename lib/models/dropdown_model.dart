class DropdownModel {
  final String id;
  final String type;
  final List<String> dropdowns;

  DropdownModel({
    required this.id,
    required this.type,
    required this.dropdowns,
  });

  // From Firestore to Dart object
  factory DropdownModel.fromJson({
    required Map<String, dynamic> document,
    required String docId,
  }) {
    return DropdownModel(
      id: docId,
      type: document['type'] ?? '',
      dropdowns: List<String>.from(document['dropdowns'] ?? []),
    );
  }

  // From Dart object to Firestore
  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'dropdowns': dropdowns};
  }
}
