import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class DetailvisitorDatasource {
  Future<Map<String, dynamic>?> fetchDetailVisitor(String id);
}

class DetailvisitorDatasourceImpl extends DetailvisitorDatasource {
  final FirebaseFirestore firestore;

  DetailvisitorDatasourceImpl({required this.firestore});

  @override
  Future<Map<String, dynamic>?> fetchDetailVisitor(String id) async {
    try {
      final visitDoc = await firestore.collection('visits').doc(id).get();
      if (!visitDoc.exists) return null;
      final visitData = visitDoc.data()!;
      final userId = visitData['userId'];
      final employeeId = visitData['employeeId'];
    if (visitData['createdAt'] != null && visitData['createdAt'] is Timestamp) {
        final createdAt = (visitData['createdAt'] as Timestamp).toDate();
        final formattedDate =
            DateFormat('dd-MM-yyyy HH:mm').format(createdAt);
        visitData['formattedDate'] = formattedDate;
      }
      Map<String, dynamic>? userData;
      if (userId != null) {
        final userDoc = await firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          userData = userDoc.data();
        }
      }

      Map<String, dynamic>? employeeData;
      if (employeeId != null) {
        final employeeDoc = await firestore
            .collection('employees')
            .doc(employeeId)
            .get();
        if (employeeDoc.exists) {
          employeeData = employeeDoc.data();
        }
      }

      final combineData = {
        ...visitData,
        'user': userData,
        'employee': employeeData,
      };
      return combineData;
    } catch (e) {
      throw Exception({'Gagal memuat data', e});
    }
  }
}
