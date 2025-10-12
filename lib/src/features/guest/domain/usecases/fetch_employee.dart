import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class FetchEmployee {
  final GuestRepository repository;
  FetchEmployee(this.repository);
  Future<List<Map<String, dynamic>>> call() {
    return repository.fetchEmployees();
  }
}