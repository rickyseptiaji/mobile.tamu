import 'package:buku_tamu/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/domain/entity/user_entity.dart';
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
      return token;
    }
    throw Exception('Failed to retrieve token');
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    await remoteDataSource.register(email, password);
    throw UnimplementedError();
  }
  
  @override
  Future<void> saveToken(String token) {
    return localDataSource.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await localDataSource.getToken();
  }
  }
