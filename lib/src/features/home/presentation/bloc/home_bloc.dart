import 'package:buku_tamu/src/features/home/domain/usecases/add_guest.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_event.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddGuestUserUseCase addGuestUserUseCase;
  HomeBloc(this.addGuestUserUseCase) : super(HomeInitial()) {
    on<SubmitGuestEventUser>((event, emit) async {
      emit(HomeLoading());
      try {
        await addGuestUserUseCase(event.employeeId, event.description);
        emit(HomeSuccess(message: 'Guest submitted successfully'));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
    on<LoadGuestsEventUser>((event, emit) async {
      emit(HomeLoading());
      try {
        // Simulate fetching guest data
        await Future.delayed(const Duration(seconds: 2));
        // Example guest data
        final guests = [
          {'name': 'John Doe', 'createdAt': '2033-10-01 10:00:00'},
          {'name': 'Jane Smith', 'createdAt': '2033-10-02 11:30:00'},
        ];
        emit(HomeLoaded(guests));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}