import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HistoryRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchHistory({
    required String userId,
    int limit,
  });
  Future<Map<String, dynamic>> fetchHistoryDetail({required String slug});
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseFirestore firestore;

  HistoryRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> fetchHistory({
    required String userId,
    int limit = 5,
  }) async {
    try {
      final querySnapshot = await firestore
          .collection('visits')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception('Failed to load history data: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
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
