import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryItem {
  final HistoryDetail history;
  final HistoryUser user;

  const HistoryItem({required this.history, required this.user});
}

class HistoryUser {
  final String userId;
  final String fullName;
  final String email;
  final String phone;
  final DateTime createdAt;

  HistoryUser({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.createdAt,
  });
}

class HistoryDetail {
  final String id;
  final String description;
  final DateTime createdAt;
  final String userId;

  HistoryDetail({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.userId,
  });
}

class HistoryPaginationResult {
  final List<HistoryItem> items;
  final DocumentSnapshot? lastDocument;

  HistoryPaginationResult({
    required this.items,
    required this.lastDocument,
  });
}
