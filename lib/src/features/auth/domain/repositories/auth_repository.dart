import 'package:buku_tamu/src/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<String> login(String email, String password);
  Future<UserEntity> register(String email, String password);
}