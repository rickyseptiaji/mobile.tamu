import 'package:buku_tamu/src/features/history/domain/entities/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HistoryRepository {
  Future<HistoryPaginationResult> getHistory({
    required String userId,
    required int limit,
    DocumentSnapshot? lastDocument,
  });
  Future<HistoryItem> getHistoryDetail({required String slug});
}
