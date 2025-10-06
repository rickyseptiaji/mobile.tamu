import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class SaveToken {
  final AuthRepository repository;

  SaveToken(this.repository);

  Future<void> call(String token) async {
    return await repository.saveToken(token);
  }
}