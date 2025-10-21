import 'package:buku_tamu/src/features/home/domain/repository/home_repository.dart';

class AddGuestUserUseCase {
  final HomeRepository repository;
  AddGuestUserUseCase(this.repository);

  Future<void> call(String employeeId, String description) async {
    return repository.addGuest(employeeId, description);
  }
}
