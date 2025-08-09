import 'package:buku_tamu/src/features/guest/domain/entity/guest.dart';

abstract class GuestRepository {
  Future<void> addGuest(GuestEntity employee);
}
