import 'package:buku_tamu/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/domain/entity/auth_user.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource auth;
  final FirebaseAuth firebaseAuth;
  AuthRepositoryImpl(this.auth, this.firebaseAuth);

  @override
  Future<void> login(String email, String password) async {
    await auth.login(email, password);
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
    await auth.register(
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
  AuthUser? getCurrentUser() {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;

    return AuthUser(id: user.uid, email: user.email);
  }

  @override
  Future<void> logout() {
    return auth.logout();
  }
}
