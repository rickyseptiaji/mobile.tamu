import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<String> call(String email, String password) async {
    return authRepository.login(email, password);
  }
}
