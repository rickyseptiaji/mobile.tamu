import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<User> call(String email, String password) async {
    return authRepository.login(email, password);
  }
}
