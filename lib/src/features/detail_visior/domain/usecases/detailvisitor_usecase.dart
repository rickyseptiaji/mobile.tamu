import 'package:buku_tamu/src/features/detail_visior/domain/repository/detailvisitor_repository.dart';

class DetailvisitorUsecase {
final DetailvisitorRepository repository;
DetailvisitorUsecase(this.repository);

  Future<Map<String,dynamic>?> fetchDetailVisitor(String id) {
    return repository.fetchDetailVisitor(id);
  }
}