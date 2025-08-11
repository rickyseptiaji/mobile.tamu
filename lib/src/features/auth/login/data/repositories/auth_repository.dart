import 'package:buku_tamu/src/features/auth/login/data/models/User.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  
  Future<void> register(String email, String password, String fullName);
  
  Future<void> signOut();
  
  Future<bool> isSignedIn();
  
  Future<User?> getCurrentUser();
  
  Future<void> updateUserProfile(String fullName, String? companyName, String? phoneNumber);
}