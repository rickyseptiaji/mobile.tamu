import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';

abstract class GuestRemoteDataSource {
  Future<void> addGuest(GuestEntity guest);
}

