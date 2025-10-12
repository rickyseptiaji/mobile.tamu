import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase(this.authRepository);
  Future<String> call(String email, String password) async {
    return await authRepository.register(email, password);
  }
}
