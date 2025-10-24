import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/transformers.dart';

abstract class HomeRemoteDataSource {
  Stream<List<Map<String, dynamic>>> fetchHistory();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({required this.firestore});

  Future<List<Map<String, dynamic>>> fetchEmployee() async {
    try {
      final querySnapshot = await firestore.collection('employees').get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('Gagal memuat data karyawan: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> fetchHistory() {
    return FirebaseAuth.instance.authStateChanges().switchMap((currentUser) {
      if (currentUser == null) {
        return Stream.value([]);
      }

      return FirebaseFirestore.instance
          .collection('visits')
          .where('userId', isEqualTo: currentUser.uid)
          .orderBy('createdAt', descending: true)
          .limit(5)
          .snapshots()
          .asyncMap((historySnapshot) async {
            List<Map<String, dynamic>> guestList = historySnapshot.docs.map((
              doc,
            ) {
              final data = doc.data();
              final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
              final formattedDate = createdAt != null
                  ? DateFormat('dd-MM-yyyy HH:mm').format(createdAt)
                  : 'Unknown';

              return {
                'id': doc.id,
                'description': data['description'] ?? '',
                'createdAt': createdAt,
                'createdAtString': formattedDate,
                'employeeId': data['employeeId'] ?? '',
                'userId': data['userId'] ?? '',
              };
            }).toList();
            final userIds = guestList
                .map((e) => e['userId'] as String)
                .toSet()
                .toList();
            if (userIds.isEmpty) return guestList;
            final userSnapshot = await firestore
                .collection('users')
                .where(FieldPath.documentId, whereIn: userIds)
                .get();
            final userMap = {
              for (var doc in userSnapshot.docs) doc.id: doc.data(),
            };

            for (var guest in guestList) {
              final user = userMap[guest['userId']];
              if (user != null) {
                final userCreatedAt = (user['createdAt'] as Timestamp?)
                    ?.toDate();
                guest['users'] = {
                  ...user,
                  'createdAt': userCreatedAt,
                  'createdAtString': userCreatedAt != null
                      ? DateFormat('dd-MM-yyyy HH:mm').format(userCreatedAt)
                      : 'Unknown',
                };
              } else {
                guest['users'] = null;
              }
            }

            return guestList;
          });
    });
  }
}
