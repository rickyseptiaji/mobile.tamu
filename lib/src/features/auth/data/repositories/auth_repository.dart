
import 'package:buku_tamu/src/features/auth/domain/entity/user_entity.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

abstract class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserEntity> login(String email, String password);

  @override
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