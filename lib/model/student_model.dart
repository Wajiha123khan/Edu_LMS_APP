class StudentModel {
  final String name;
  final String id;
  final String branchCode;
  final String admissionDate;
  final String status;

  StudentModel({
    required this.name,
    required this.id,
    required this.branchCode,
    required this.admissionDate,
    required this.status,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      id: json['id'],
      branchCode: json['branchCode'],
      admissionDate: json['admissionDate'],
      status: json['status'],
    );
  }
}
