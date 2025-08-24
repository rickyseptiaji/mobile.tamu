import 'package:equatable/equatable.dart';

class GuestState extends Equatable {
  final List<Map<String, dynamic>> employees;
  final bool employeesLoading;
  final String companyName;
  final String fullName;
  final String email;
  final String countryCode;
  final String phone;
  final String toEmployee;
   final String description;
  final bool isLoading;
  final String? error;
  final bool success;

  const GuestState({
    this.employees = const [],
    this.employeesLoading = false,
    this.companyName = '',
    this.fullName = '',
    this.email = '',
    this.countryCode = '+62',
    this.phone = '',
    this.toEmployee = '',
    this.description = '',
    this.isLoading = false,
    this.error,
    this.success = false,
  });

  GuestState copyWith({
    List<Map<String, dynamic>>? employees,
    bool? employeesLoading,
    String? companyName,
    String? fullName,
    String? email,
    String? countryCode,
    String? phone,
    String? toEmployee,
    String? description,
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return GuestState(
      employees: employees ?? this.employees,
      employeesLoading: employeesLoading ?? this.employeesLoading,
      companyName: companyName ?? this.companyName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      phone: phone ?? this.phone,
      toEmployee: toEmployee ?? this.toEmployee,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
    employees,
    employeesLoading,
    companyName,
    fullName,
    email,
    countryCode,
    phone,
    toEmployee,
    description,
    isLoading,
    error,
    success,
  ];
}
