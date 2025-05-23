class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String address;
  final String unit;
  final String branchName;
  final String vendor;
  final String type;
  final String jobStatus;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.unit,
    required this.branchName,
    required this.vendor,
    required this.type,
    required this.jobStatus,
  });

  /// Factory constructor to create a model from Firestore doc
  factory ProjectModel.fromJson(Map<String, dynamic> data, String docId) {
    return ProjectModel(
      id: docId,
      name: data['name'] ?? '',
      description: data['description'] ?? 'No description',
      address: data['address'] ?? '',
      unit: data['unit'] ?? '',
      branchName: data['branchName'] ?? '',
      vendor: data['vendor'] ?? '',
      type: data['type'] ?? '',
      jobStatus: data['jobStatus'] ?? '',
    );
  }

  /// For uploading or updating the document (excluding docId)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'unit': unit,
      'branchName': branchName,
      'vendor': vendor,
      'type': type,
      'jobStatus': jobStatus,
    };
  }
}
