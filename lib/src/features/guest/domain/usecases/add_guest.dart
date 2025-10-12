import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class AddGuest {
  final GuestRepository employeeRepository;
  AddGuest(this.employeeRepository);

  Future<void> call(GuestEntity employee) {
    return employeeRepository.addGuest(employee);
  }
}
