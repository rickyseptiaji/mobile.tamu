import 'package:buku_tamu/src/features/auth/domain/entity/user_entity.dart';

abstract class AuthDataSource {
  Future<UserEntity> login(String email, String password);

  Future<void> register(String email, String password, String fullName);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<UserEntity?> getCurrentUser();

  Future<void> updateUserProfile(
    String fullName,
    String? companyName,
    String? phoneNumber,
  );
}

class AuthDataSourceImpl implements AuthDataSource {
  // Implementation of the methods would go here, typically involving network calls or local storage access.

  @override
  Future<UserEntity> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<UserEntity?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserProfile(
    String fullName,
    String? companyName,
    String? phoneNumber,
  ) {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }
}
