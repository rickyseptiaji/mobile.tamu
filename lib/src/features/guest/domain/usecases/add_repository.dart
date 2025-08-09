import 'package:buku_tamu/src/features/guest/domain/entity/guest.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class AddRepository {
  final GuestRepository employeeRepository;
  AddRepository(this.employeeRepository);

  Future<void> call(GuestEntity employee) {
    return employeeRepository.addGuest(employee);
  }
}