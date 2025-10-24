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
      final guestQuery = await firestore
          .collection('guests')
          .where('email', isEqualTo: guest.email)
          .limit(1)
          .get();
      DocumentReference guestRef;
      if (guestQuery.docs.isNotEmpty) {
        guestRef = guestQuery.docs.first.reference;
        await guestRef.update({'visitCount': FieldValue.increment(1)});
      } else {
        guestRef = firestore.collection('guests').doc();
        await guestRef.set({
          'id': guestRef.id,
          'email': guest.email,
          'fullName': guest.fullName,
          'companyName': guest.companyName,
          'phone': guest.phone,
          'userId': null,
          'visitCount': FieldValue.increment(1),
        });
      }

      final visitRef = firestore.collection('visits').doc();
      await visitRef.set({
        'id': visitRef.id,
        'guestId': guestRef.id,
        'employeeId': guest.employeeId,
        'description': guest.description,
        'createdAt': FieldValue.serverTimestamp(),
      });
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
