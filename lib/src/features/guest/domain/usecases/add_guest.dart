import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class AddGuest {
  final GuestRepository repository;
  AddGuest(this.repository);

  Future<void> call(GuestEntity guest) {
    return repository.addGuest(guest);
  }
}
