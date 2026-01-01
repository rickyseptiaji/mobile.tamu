import 'package:bloc/bloc.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/history/domain/repository/history_repository.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_event.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_state.dart';

class HomeHistoryBloc extends Bloc<HomeHistoryEvent, HomeHistoryState> {
  final HistoryRepository repository;
  final AuthRepository authRepository;

  HomeHistoryBloc(this.repository, this.authRepository)
    : super(const HomeHistoryState()) {
    on<HomeHistoryFetch>(_onFetch);
     on<LoadHistoryDetail>(_onLoadDetail);
  }

  Future<void> _onFetch(
    HomeHistoryFetch event,
    Emitter<HomeHistoryState> emit,
  ) async {
    emit(state.copyWith(status: HomeHistoryStatus.loading));
    final userId = authRepository.getCurrentUser()?.id;
    try {
      final data = await repository.getHistory(
        userId: userId!,
        limit: event.limit,
      );

      emit(state.copyWith(status: HomeHistoryStatus.success, histories: data));
    } catch (_) {
      emit(state.copyWith(status: HomeHistoryStatus.failure));
    }
  }

  Future<void> _onLoadDetail(
    LoadHistoryDetail event,
    Emitter<HomeHistoryState> emit,
  ) async {
    emit(state.copyWith(status: HomeHistoryStatus.loading));
    try {
      final detail = await repository.getHistoryDetail(slug: event.slug);
      emit(state.copyWith(
        status: HomeHistoryStatus.success,
        selectedHistory: detail,
      ));
    } catch (_) {
      emit(state.copyWith(status: HomeHistoryStatus.failure));
    }
  }
  
}
