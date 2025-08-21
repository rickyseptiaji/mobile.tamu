import 'package:buku_tamu/src/features/auth/domain/entity/user_entity.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  Future<UserEntity> call(String email, String password) async {
    return authRepository.login(email, password);
  }
}
