import 'package:buku_tamu/src/features/auth/domain/entity/user_entity.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase(this.authRepository);
  Future<UserEntity> call(String email, String password) async {
    return await authRepository.register(email, password);
  }
}
