import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<User> login(String email, String password);
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
