import 'package:buku_tamu/src/features/home/domain/usecases/fetch_history.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_event.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchHistoryUseCase fetchHistoryUseCase;
  HomeBloc(this.fetchHistoryUseCase) : super(HomeInitial()) {
    on<LoadGuestsEventUser>((event, emit) async {
      emit(HomeLoading());
      try { 
        await emit.forEach<List<Map<String, dynamic>>>(
          fetchHistoryUseCase(),
          onData: (guests) => HomeLoaded(guests),
          onError: (error, stackTrace) => HomeError(error.toString()),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
