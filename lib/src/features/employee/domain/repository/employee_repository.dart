import 'package:buku_tamu/src/features/employee/data/models/employee_models.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeModel>> fetchEmployees();
}