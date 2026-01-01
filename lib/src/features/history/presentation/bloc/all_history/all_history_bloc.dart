import 'package:bloc/bloc.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/history/domain/repository/history_repository.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_event.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_state.dart';

class AllHistoryBloc extends Bloc<AllHistoryEvent, AllHistoryState> {
  final HistoryRepository repository;
  final AuthRepository authRepository;

  AllHistoryBloc(this.repository, this.authRepository)
      : super(const AllHistoryState()) {
    on<AllHistoryFetch>(_onFetchAllHistory);
    on<AllHistoryLoadMore>(_onLoadMoreHistory);
  }

  Future<void> _onFetchAllHistory(
    AllHistoryFetch event,
    Emitter<AllHistoryState> emit,
  ) async {
    emit(state.copyWith(
      status: AllHistoryStatus.loading,
      page: 1,
      hasReachedMax: false,
      histories: [],
    ));

    final userId = authRepository.getCurrentUser()?.id;

    try {
      final data = await repository.getHistory(
        userId: userId!,
        page: 1,
        limit: event.limit,
      );

      emit(state.copyWith(
        status: AllHistoryStatus.success,
        histories: data,
        page: 1,
        hasReachedMax: data.length < event.limit,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AllHistoryStatus.failure,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreHistory(
    AllHistoryLoadMore event,
    Emitter<AllHistoryState> emit,
  ) async {
    if (state.hasReachedMax ||
        state.status == AllHistoryStatus.loadingMore) return;

    emit(state.copyWith(status: AllHistoryStatus.loadingMore));

    final userId = authRepository.getCurrentUser()?.id;
    final nextPage = state.page + 1;

    try {
      final data = await repository.getHistory(
        userId: userId!,
        page: nextPage,
        limit: event.limit,
      );

      emit(state.copyWith(
        status: AllHistoryStatus.success,
        histories: [...state.histories, ...data], // 🔥 APPEND
        page: nextPage,
        hasReachedMax: data.length < event.limit,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AllHistoryStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
