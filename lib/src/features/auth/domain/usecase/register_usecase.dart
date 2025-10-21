import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase(this.authRepository);
  Future<String> call(
    String email,
    String password,
    String fullName,
    String companyName,
    String countryCode,
    String phone,
  ) async {
    return await authRepository.register(
      email,
      password,
      fullName,
      companyName,
      countryCode,
      phone,
    );
  }
}
