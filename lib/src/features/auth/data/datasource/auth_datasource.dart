import 'package:buku_tamu/src/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);

  Future<UserModel> register(String email, String password);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<UserModel?> getCurrentUser();

  Future<void> updateUserProfile(
    String fullName,
    String? companyName,
    String? phoneNumber,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Implementation of the methods would go here, typically involving network calls or local storage access.

  @override
  Future<UserModel> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<UserModel> register(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        throw Exception('User registration failed');
      }

      return UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      // Handle registration errors
      throw Exception('Registration failed: ${e.message}');
    }
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
