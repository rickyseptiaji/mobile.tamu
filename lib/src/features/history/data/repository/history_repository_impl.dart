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
  Future<List<HistoryItem>> getHistory({
    required String userId,
    int page = 1,
    int limit = 5,
  }) async {
    final visits = await remote.fetchHistory(userId: userId, limit: limit);
    final userIds = visits.map((e) => e['userId'] as String).toSet();
    final usersMap = <String, HistoryUser>{};
    if (userIds.isNotEmpty) {
      final querySnapshot = await firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds.toList())
          .get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        usersMap[doc.id] = HistoryUser(
          userId: doc.id,
          fullName: data['fullName'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
      }
    }
    return visits.map((visit) {
      final history = HistoryDetailModel.fromFirestore(
        visit['id'] as String,
        visit,
      );
      final user = usersMap[history.userId];
      return HistoryItemModel(
        history: history,
        user: user != null
            ? HistoryUserModel(
                userId: user.userId,
                fullName: user.fullName,
                email: user.email,
                phone: user.phone,
                createdAt: user.createdAt,
              )
            : null,
      );
    }).toList();
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
