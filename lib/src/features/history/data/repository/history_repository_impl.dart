import 'package:buku_tamu/src/features/history/data/datasource/history_datasource.dart';
import 'package:buku_tamu/src/features/history/data/models/history_model.dart';
import 'package:buku_tamu/src/features/history/domain/entities/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remote;
  final FirebaseFirestore firestore;
  
  HistoryRepositoryImpl({required this.remote, required this.firestore});
  @override
  @override
Future<HistoryPaginationResult> getHistory({
  required String userId,
  required int limit,
  DocumentSnapshot? lastDocument,
}) async {
  final docs = await remote.fetchHistory(
    userId: userId,
    limit: limit,
    lastDocument: lastDocument,
  );

  final List<HistoryItem> items = [];

  for (final doc in docs) {
    final data = doc.data() as Map<String, dynamic>;

    final history = HistoryDetail(
      id: doc.id,
      employeeId: data['employeeId'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
    );

    // 🔵 USER
    final userDoc = await firestore
        .collection('users')
        .doc(history.userId)
        .get();

    final user = userDoc.exists
        ? HistoryUser(
            userId: userDoc.id,
            fullName: userDoc.data()!['fullName'] ?? '',
            email: userDoc.data()!['email'] ?? '',
            phone: userDoc.data()!['phone'] ?? '',
            createdAt: (userDoc.data()!['createdAt'] as Timestamp).toDate(),
          )
        : HistoryUser(
            userId: '',
            fullName: '',
            email: '',
            phone: '',
            createdAt: DateTime.now(),
          );

    // 🔵 EMPLOYEE
    final employeeDoc = await firestore
        .collection('employees')
        .doc(history.employeeId)
        .get();

    final employee = HistoryEmployee(
      employeeId: history.employeeId,
      fullName: employeeDoc.data()?['fullName'] ?? '',
    );

    // 🔵 ADD ITEM (NO NULL GUARD BLOCKING)
    items.add(
      HistoryItem(
        history: history,
        user: user,
        employee: employee,
      ),
    );
  }

  return HistoryPaginationResult(
    items: items,
    lastDocument: docs.isNotEmpty ? docs.last : null,
  );
}

@override
Future<HistoryItem> getHistoryDetail({required String slug}) async {
  final visit = await remote.fetchHistoryDetail(slug: slug);

  final history = HistoryDetailModel.fromFirestore(
    visit['id'] as String,
    visit,
  );

  // 🔵 USER
  HistoryUserModel? user;
  final userId = visit['userId'];

  if (userId != null) {
    final userDoc = await firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final data = userDoc.data()!;
      user = HistoryUserModel(
        userId: userDoc.id,
        fullName: data['fullName'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    }
  }

  // 🔵 EMPLOYEE (INI YANG KAMU LUPA)
  HistoryEmployee employee = HistoryEmployee(
    employeeId: history.employeeId,
    fullName: '',
  );

  final employeeDoc = await firestore
      .collection('employees')
      .doc(history.employeeId)
      .get();

  if (employeeDoc.exists) {
    final data = employeeDoc.data()!;
    employee = HistoryEmployee(
      employeeId: history.employeeId,
      fullName: data['fullName'] ?? '',
    );
  }

  // 🔵 RETURN FINAL
  return HistoryItemModel(
    history: history,
    user: user ?? HistoryUserModel(
      userId: '',
      fullName: '',
      email: '',
      phone: '',
      createdAt: DateTime.now(),
    ),
    employee: employee,
  );
}}