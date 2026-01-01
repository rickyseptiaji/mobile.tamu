import 'package:buku_tamu/src/features/employee/domain/repository/employee_repository.dart';
import 'package:buku_tamu/src/features/employee/presentation/bloc/employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repository;
  EmployeeCubit(this.repository) : super(EmployeeState());

  Future<void> fetchEmployees() async {
    emit(state.copyWith(status: EnumEmployeeState.loading));
    try {
      final employees = await repository.fetchEmployees();
      emit(
        state.copyWith(status: EnumEmployeeState.loaded, employees: employees),
      );
    } catch (_) {
      emit(state.copyWith(status: EnumEmployeeState.error));
    }
  }
}
