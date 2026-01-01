import 'package:buku_tamu/src/features/guest/data/datasource/guest_datasource.dart';
import 'package:buku_tamu/src/features/guest/data/models/guest_models.dart';
import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class GuestRepositoryImpl implements GuestRepository {
  final GuestRemoteDataSource remoteDataSource;

  GuestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addGuest(GuestEntity guest) {
    final guestModel = GuestModel.fromEntity(guest);
    return remoteDataSource.addGuest(guestModel);
  }

}
