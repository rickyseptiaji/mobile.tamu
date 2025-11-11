import 'package:buku_tamu/src/features/detail_visitor/data/datasource/detailvisitor_datasource.dart';
import 'package:buku_tamu/src/features/detail_visitor/domain/repository/detailvisitor_repository.dart';

class DetailvisitorRepositoryImpl extends DetailvisitorRepository {
  final DetailvisitorDatasource remoteDataSource;

  DetailvisitorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>?> fetchDetailVisitor(String id) {
    return remoteDataSource.fetchDetailVisitor(id);
  }
}
