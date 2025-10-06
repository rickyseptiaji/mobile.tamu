import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();   
  Future<void> deleteToken();
}

class LocalDataSourceImpl implements LocalDataSource {
  final FlutterSecureStorage secureStorage;

  LocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'auth_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'auth_token');
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'auth_token');
  }
}