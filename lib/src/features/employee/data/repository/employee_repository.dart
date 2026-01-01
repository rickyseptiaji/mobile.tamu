import 'package:buku_tamu/src/features/employee/data/datasource/employee_datasource.dart';
import 'package:buku_tamu/src/features/employee/data/models/employee_models.dart';
import 'package:buku_tamu/src/features/employee/domain/repository/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource  remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<EmployeeModel>> fetchEmployees() async {
    final employeeMaps = await remoteDataSource.fetchEmployees();
    return employeeMaps
        .map((map) => EmployeeModel.fromMap(map))
        .toList();
        
  }
}

