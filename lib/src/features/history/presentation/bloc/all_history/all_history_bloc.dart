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
    on<AllHistoryFetch>(_onFetch);
    on<AllHistoryLoadMore>(_onLoadMore);
  }

  Future<void> _onFetch(
    AllHistoryFetch event,
    Emitter<AllHistoryState> emit,
  ) async {
    emit(const AllHistoryState(status: AllHistoryStatus.loading));

    final userId = authRepository.getCurrentUser()?.id;

    try {
      final result = await repository.getHistory(
        userId: userId!,
        limit: event.limit,
      );

      emit(
        state.copyWith(
          status: AllHistoryStatus.success,
          histories: result.items,
          lastDocument: result.lastDocument,
          hasReachedMax: result.items.length < event.limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllHistoryStatus.failure, error: e.toString()),
      );
    }
  }
Future<void> _onLoadMore(
  AllHistoryLoadMore event,
  Emitter<AllHistoryState> emit,
) async {
  if (state.hasReachedMax ||
      state.status == AllHistoryStatus.loadingMore) {
    return;
  }

  emit(state.copyWith(status: AllHistoryStatus.loadingMore));

  final userId = authRepository.getCurrentUser()?.id;

  try {
    final result = await repository.getHistory(
      userId: userId!,
      limit: event.limit,
      lastDocument: state.lastDocument,
    );

    emit(
      state.copyWith(
        status: AllHistoryStatus.success,
        histories: [...state.histories, ...result.items],
        lastDocument: result.lastDocument,
        hasReachedMax: result.items.length < event.limit,
      ),
    );
  } catch (e) {
    emit(
      state.copyWith(
        status: AllHistoryStatus.success,
        error: e.toString(),
      ),
    );
  }
}

}
