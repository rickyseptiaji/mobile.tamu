import 'package:buku_tamu/src/features/employee/data/models/employee_models.dart';

enum EnumEmployeeState { initial, loading, loaded, error }
class EmployeeState {
  final EnumEmployeeState status;
  final List<EmployeeModel> employees;
  final String? error;

  EmployeeState({
    this.status = EnumEmployeeState.initial,
    this.employees = const [],
    this.error,
  });

  EmployeeState copyWith({
    EnumEmployeeState? status,
    List<EmployeeModel>? employees,
    String? error,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      error: error,
    );
  }
}