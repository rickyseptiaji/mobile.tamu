
abstract class AuthRepository {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<String> login(String email, String password);
  Future<String> register(String email, String password);
  Future<void> logout();
}