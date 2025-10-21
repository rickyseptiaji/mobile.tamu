import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class AddGuestUseCase {
  final GuestRepository repository;
  AddGuestUseCase(this.repository);

  Future<void> call(GuestEntity guest) {
    return repository.addGuest(guest);
  }
}
