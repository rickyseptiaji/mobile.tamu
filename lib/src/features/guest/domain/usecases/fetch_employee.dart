import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class FetchEmployeeUseCase {
  final GuestRepository repository;
  FetchEmployeeUseCase(this.repository);
  Future<List<Map<String, dynamic>>> call() {
    return repository.fetchEmployees();
  }
}