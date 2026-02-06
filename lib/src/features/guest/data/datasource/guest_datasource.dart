import 'package:buku_tamu/src/features/guest/data/models/guest_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GuestRemoteDataSource {
  Future<void> addGuest(GuestModel guest);
}

class GuestRemoteDataSourceImpl implements GuestRemoteDataSource {
  final FirebaseFirestore firestore;

  GuestRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addGuest(GuestModel guest) async {
    try {
      final guestQuery = await firestore
          .collection('guests')
          .where('phone', isEqualTo: guest.phone)
          .limit(1)
          .get();
      DocumentReference guestRef;
      if (guestQuery.docs.isNotEmpty) {
        final existingGuestDoc = guestQuery.docs.first;
        guestRef = existingGuestDoc.reference;
        await guestRef.update({
          'fullName': guest.fullName,
          'email': guest.email,
          'companyName': guest.companyName,
        });
      } else {
        guestRef = firestore.collection('guests').doc();
        await guestRef.set({
          'id': guestRef.id,
          'email': guest.email,
          'fullName': guest.fullName,
          'companyName': guest.companyName,
          'phone': guest.phone,
        });
      }

      final visitRef = firestore.collection('visits').doc();
      await visitRef.set({
        'id': visitRef.id,
        'guestId': guestRef.id,
        'employeeId': guest.employeeId,
        'description': guest.description,
        'checkIn': FieldValue.serverTimestamp(),
        'checkOut': null,
        'duration': null,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Gagal menambahkan tamu: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }

}
