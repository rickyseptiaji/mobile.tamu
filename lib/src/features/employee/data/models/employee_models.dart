import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String id;
  final String fullName;
  final String division;
  final String email;
  final String phone;
  final DateTime createdAt;

  EmployeeModel({
    required this.id,
    required this.fullName,
    required this.division,
    required this.email,
    required this.phone,
    required this.createdAt,
  });

  factory EmployeeModel.fromMap(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      fullName: json['fullName'],
      division: json['division'],
      email: json['email'],
      phone: json['phone'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'division': division,
      'email': email,
      'phone': phone,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}