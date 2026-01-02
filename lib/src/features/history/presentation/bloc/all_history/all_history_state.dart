import 'package:buku_tamu/src/features/history/domain/entities/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AllHistoryStatus {
  initial,
  loading,
  success,
  loadingMore,
  failure,
}

class AllHistoryState {
  final AllHistoryStatus status;
  final List<HistoryItem> histories;
  final bool hasReachedMax;
  final DocumentSnapshot? lastDocument;
  final String? error;

  const AllHistoryState({
    this.status = AllHistoryStatus.initial,
    this.histories = const [],
    this.hasReachedMax = false,
    this.lastDocument,
    this.error,
  });

  AllHistoryState copyWith({
    AllHistoryStatus? status,
    List<HistoryItem>? histories,
    bool? hasReachedMax,
    DocumentSnapshot? lastDocument,
    String? error,
  }) {
    return AllHistoryState(
      status: status ?? this.status,
      histories: histories ?? this.histories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastDocument: lastDocument ?? this.lastDocument,
      error: error,
    );
  }
}
