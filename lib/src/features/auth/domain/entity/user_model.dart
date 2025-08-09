import 'package:buku_tamu/src/features/auth/data/models/User.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.fullName,
    required String super.companyName,
    required String super.phoneNumber,
    required String password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'], 
      fullName: json['full_name'],
      companyName: json['company_name'],
      phoneNumber: json['phone_number'],
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'full_name': fullName,
      'company_name': companyName,
      'phone_number': phoneNumber,
    };
  }
}
