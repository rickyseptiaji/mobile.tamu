import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeRemoteDataSource {
  Future<void> addGuest(String employeeId, String description);
  Future<List<Map<String, dynamic>>> fetchGuest();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({required this.firestore});

  @override
  Future<String> addGuest(String employeeId, String description) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User tidak terautentikasi');
      }
      final userId = user.uid;
      final querySnapshot = await firestore
          .collection('users')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isEmpty) {
        throw Exception('data tidak ditemukan untuk user ini');
      }
      final userDocId = querySnapshot.docs.first.id;
      await firestore.collection('guests').add({
        'employeeId': employeeId,
        'description': description,
        'createdBy': userDocId,
        'role': 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Gagal menambahkan tamu: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
    return 'Tamu berhasil ditambahkan';
  }

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
  Future<List<Map<String, dynamic>>> fetchGuest() async {
    try {
      final querySnapshot = await firestore.collection('guest').get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('Gagal memuat data karyawan: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }
}
