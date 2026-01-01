import 'package:buku_tamu/src/features/history/domain/entities/history.dart';

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
  final int page;
  final bool hasReachedMax;
  final String? error;

  const AllHistoryState({
    this.status = AllHistoryStatus.initial,
    this.histories = const [],
    this.page = 1,
    this.hasReachedMax = false,
    this.error,
  });

  AllHistoryState copyWith({
    AllHistoryStatus? status,
    List<HistoryItem>? histories,
    int? page,
    bool? hasReachedMax,
    String? error,
  }) {
    return AllHistoryState(
      status: status ?? this.status,
      histories: histories ?? this.histories,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }
}

