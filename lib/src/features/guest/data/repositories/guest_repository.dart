import 'package:buku_tamu/src/features/guest/domain/entity/guest.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';

class GuestRepositoryImpl implements GuestRepository {
  // This would typically interact with a data source, such as a database or API.
  
  @override
  Future<void> addGuest(GuestEntity guest) async {
    // Implementation for adding a guest to the data source.
    // For example, this could be an API call or a database insert operation.
  }
  
}