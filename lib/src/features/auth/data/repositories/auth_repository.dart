import 'package:buku_tamu/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/domain/entity/user_entity.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> register(String email, String password) async {
    return await remoteDataSource.register(email, password);
  }
  
  @override
  Future<UserEntity> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

}
