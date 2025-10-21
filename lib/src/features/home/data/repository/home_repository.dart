import 'package:buku_tamu/src/features/home/data/datasource/home_datasource.dart';
import 'package:buku_tamu/src/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Map<String, dynamic>>> fetchGuest() async {
    return remoteDataSource.fetchGuest();
  }

  @override
  Future<void> addGuest(String employeeId, String description) async {
    return remoteDataSource.addGuest(employeeId, description);
  }
}
