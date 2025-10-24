import 'package:buku_tamu/src/features/home/domain/repository/home_repository.dart';

class FetchHistoryUseCase {
  final HomeRepository repository;
  FetchHistoryUseCase(this.repository);
  Stream<List<Map<String, dynamic>>> call()  {
    return repository.fetchHistory();
  }
}