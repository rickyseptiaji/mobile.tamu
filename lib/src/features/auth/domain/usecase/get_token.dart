import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class GetToken {
  final AuthRepository repository;
  GetToken(this.repository);

  Future<String?> call() async {
    return await repository.getToken();
  }
}