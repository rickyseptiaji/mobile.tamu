import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';

abstract class GuestRepository {
  Future<void> addGuest(GuestEntity employee);
}
