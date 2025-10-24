import 'package:buku_tamu/src/features/home/data/datasource/home_datasource.dart';
import 'package:buku_tamu/src/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});
  @override
  Stream<List<Map<String, dynamic>>> fetchHistory()  {
    return remoteDataSource.fetchHistory();
  }


}
