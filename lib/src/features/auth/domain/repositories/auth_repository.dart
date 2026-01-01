
import 'package:buku_tamu/src/features/auth/domain/entity/auth_user.dart';

abstract class AuthRepository {
  AuthUser? getCurrentUser();
  Future<void> login(String email, String password);
  Future<String> register(
    String email,
    String password,
    String fullName,
    String companyName,
    String countryCode,
    String phone,
  );
  Future<void> logout();
}
