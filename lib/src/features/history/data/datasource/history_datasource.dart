import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HistoryRemoteDataSource {
  Future<List<QueryDocumentSnapshot>> fetchHistory({
    required String userId,
    required int limit,
    DocumentSnapshot? lastDocument,
  });
  Future<Map<String, dynamic>> fetchHistoryDetail({required String slug});
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseFirestore firestore;

  HistoryRemoteDataSourceImpl({required this.firestore});

 @override
  Future<List<QueryDocumentSnapshot>> fetchHistory({
    required String userId,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      Query query = firestore
          .collection('visits')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();
      return snapshot.docs;
    } on FirebaseException catch (e) {
      throw Exception('Failed to load history: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> fetchHistoryDetail({
    required String slug,
  }) async {
    try {
      final docSnapshot = await firestore.collection('visits').doc(slug).get();

      if (!docSnapshot.exists) {
        throw Exception('History with slug $slug not found');
      }
      return {'id': docSnapshot.id, ...docSnapshot.data()!};
    } on FirebaseException catch (e) {
      throw Exception('Failed to load history detail: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
