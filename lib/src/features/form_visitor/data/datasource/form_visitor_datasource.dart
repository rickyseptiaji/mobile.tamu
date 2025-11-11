import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class FormVisitorDatasource {
  Future<String> addVisitor(String employeeId, String description);
}

class FormVisitorRemoteDataSourceImpl implements FormVisitorDatasource {
  final FirebaseFirestore firestore;

  FormVisitorRemoteDataSourceImpl({required this.firestore});

  @override
  Future<String> addVisitor(String employeeId, String description) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User tidak terautentikasi');
      }

      final userId = user.uid;
      final visitRef = firestore.collection('visits').doc();
      await visitRef.set({
        'id': visitRef.id,
        'userId': userId,
        'employeeId': employeeId,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return 'Tamu berhasil ditambahkan';
    } on FirebaseException catch (e) {
      throw Exception('Gagal menambahkan tamu: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }
}
