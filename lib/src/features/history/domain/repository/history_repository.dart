import 'package:buku_tamu/src/features/history/domain/entities/history.dart';

abstract class HistoryRepository {
  Future<List<HistoryItem>> getHistory({
    required String userId,
    int limit,
    int page,
  });
  Future<HistoryItem> getHistoryDetail({required String slug});
}
