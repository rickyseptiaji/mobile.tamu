import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/history.dart';

class HistoryItemModel extends HistoryItem {
  HistoryItemModel({
    required HistoryDetailModel history,
    HistoryUserModel? user,
  }) : super(
          history: history,
          user: user!,
        );

  factory HistoryItemModel.fromFirestore(
    String id,
    Map<String, dynamic> json,
  ) {
    return HistoryItemModel(
      history: HistoryDetailModel.fromFirestore(id, json),
      user: json['user'] == null
          ? null
          : HistoryUserModel.fromMap(
              json['user'],
            ),
    );
  }
}
class HistoryUserModel extends HistoryUser {
  HistoryUserModel({
    required super.userId,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.createdAt,
  });

  factory HistoryUserModel.fromMap(Map<String, dynamic> map) {
    return HistoryUserModel(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
class HistoryDetailModel extends HistoryDetail {
  HistoryDetailModel({
    required super.id,
    required super.description,
    required super.createdAt,
    required super.userId,
  });

  factory HistoryDetailModel.fromFirestore(
    String id,
    Map<String, dynamic> json,
  ) {
    return HistoryDetailModel(
      id: id,
      description: json['description'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      userId: json['userId'] ?? '',
    );
  }
}