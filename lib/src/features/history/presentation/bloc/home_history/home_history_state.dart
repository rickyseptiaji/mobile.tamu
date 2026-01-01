import 'package:buku_tamu/src/features/history/domain/entities/history.dart';
enum HomeHistoryStatus { initial, loading, success, failure }

class HomeHistoryState {
  final HomeHistoryStatus status;
  final List<HistoryItem> histories;
  final HistoryItem? selectedHistory;
  final String? error;

  const HomeHistoryState({
    this.status = HomeHistoryStatus.initial,
    this.histories = const [],
    this.selectedHistory,
    this.error,
  });

  HomeHistoryState copyWith({
    HomeHistoryStatus? status,
    List<HistoryItem>? histories,
    HistoryItem? selectedHistory,
    String? error,
  }) {
    return HomeHistoryState(
      status: status ?? this.status,
      histories: histories ?? this.histories,
      selectedHistory: selectedHistory ?? this.selectedHistory,
      error: error,
    );
  }
}

