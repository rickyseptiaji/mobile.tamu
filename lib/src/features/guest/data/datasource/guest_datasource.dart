import 'package:buku_tamu/src/features/guest/data/models/guest_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GuestRemoteDataSource {
  Future<void> addGuest(GuestModel guest);
    Future<List<Map<String, dynamic>>> fetchEmployees();
}

class GuestRemoteDataSourceImpl implements GuestRemoteDataSource {
  final FirebaseFirestore firestore;

  GuestRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addGuest(GuestModel guest) async {
    try {
      final docRef = firestore.collection('guests').doc();
      await docRef.set(guest.toMap()..['id'] = docRef.id);
    } on FirebaseException catch (e) {
      throw Exception('Gagal menambahkan tamu: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchEmployees() async {
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
}
