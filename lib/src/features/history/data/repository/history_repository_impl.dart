import 'package:buku_tamu/src/features/history/data/datasource/history_datasource.dart';
import 'package:buku_tamu/src/features/history/data/models/history_model.dart';
import 'package:buku_tamu/src/features/history/domain/entities/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remote;
  final FirebaseFirestore firestore;

  HistoryRepositoryImpl({required this.remote, required this.firestore});
  @override
  Future<HistoryPaginationResult> getHistory({
    required String userId,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    final docs = await remote.fetchHistory(
      userId: userId,
      limit: limit,
      lastDocument: lastDocument,
    );

    final List<HistoryItem> items = [];

    for (final doc in docs) {
      final data = doc.data() as Map<String, dynamic>;

      final history = HistoryDetail(
        id: doc.id,
        description: data['description'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        userId: data['userId'],
      );

      // 🔥 ambil user
      final userDoc = await firestore
          .collection('users')
          .doc(history.userId)
          .get();

      HistoryUser? user;

      if (userDoc.exists) {
        final u = userDoc.data()!;
        user = HistoryUser(
          userId: userDoc.id,
          fullName: u['fullName'],
          email: u['email'],
          phone: u['phone'],
          createdAt: (u['createdAt'] as Timestamp).toDate(),
        );
      }

      items.add(HistoryItem(history: history, user: user!));
    }

    return HistoryPaginationResult(
      items: items,
      lastDocument: docs.isNotEmpty ? docs.last : null,
    );
  }

  @override
  Future<HistoryItem> getHistoryDetail({required String slug}) async {
    final visit = await remote.fetchHistoryDetail(slug: slug);

    final history = HistoryDetailModel.fromFirestore(
      visit['id'] as String,
      visit,
    );

    HistoryUserModel? user;
    final userId = visit['userId'];

    if (userId != null) {
      final userDoc = await firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        user = HistoryUserModel(
          userId: userDoc.id,
          fullName: data['fullName'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
      }
    }

    return HistoryItemModel(history: history, user: user);
  }
}
