import 'package:buku_tamu/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource remoteDataSource;
  final LocalDataSource localDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<String> login(String email, String password) async {
    final userCredential = await remoteDataSource.login(email, password);
    final token = await userCredential.user?.getIdToken();
    if (token != null) {
      await localDataSource.saveToken(token);
      return 'Login successful';
    }
    throw Exception('Failed to retrieve token');
  }

  @override
  Future<String> register(
    String email,
    String password,
    String fullName,
    String companyName,
    String countryCode,
    String phone,
  ) async {
    await remoteDataSource.register(
      email,
      password,
      fullName,
      companyName,
      countryCode,
      phone,
    );
    return 'Registration successful';
  }

  @override
  Future<void> saveToken(String token) {
    return localDataSource.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await localDataSource.getToken();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.deleteToken();
  }
}
