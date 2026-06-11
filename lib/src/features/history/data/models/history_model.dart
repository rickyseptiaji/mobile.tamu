import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/history.dart';

class HistoryItemModel extends HistoryItem {
  HistoryItemModel({
    required HistoryDetailModel super.history,
    required HistoryUserModel super.user,
    required super.employee,
  });

  factory HistoryItemModel.fromFirestore(
    String id,
    Map<String, dynamic> json,
    HistoryUserModel user,
    HistoryEmployee employee,
  ) {
    return HistoryItemModel(
      history: HistoryDetailModel.fromFirestore(id, json),
      user: user,
      employee: employee,
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
    required super.employeeId,
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
      employeeId: json['employeeId'] ?? '',
      description: json['description'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      userId: json['userId'] ?? '',
    );
  }
}
