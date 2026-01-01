import 'package:cloud_firestore/cloud_firestore.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchEmployees();
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final FirebaseFirestore firestore;

  EmployeeRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> fetchEmployees() async {
    try {
      final querySnapshot = await firestore.collection('employees').get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('Gagal mengambil data karyawan: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }
}