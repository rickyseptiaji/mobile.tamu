import 'package:bloc/bloc.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  final GuestRepository repository;
  GuestBloc(this.repository) : super(GuestInitial()) {
    on<SubmitGuestEvent>((event, emit) async {
      emit(FormSubmitting());
      try {
        await repository.addGuest(event.guest);
        emit(GuestSuccess(message: 'Tamu berhasil ditambahkan'));
      } catch (e) {
        emit(GuestError(e.toString()));
      }
    });
  }
}
