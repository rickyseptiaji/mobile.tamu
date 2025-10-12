import 'package:bloc/bloc.dart';
import 'package:buku_tamu/src/features/guest/domain/usecases/add_guest.dart';
import 'package:buku_tamu/src/features/guest/domain/usecases/fetch_employee.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  final FirebaseFirestore firestore;
  final AddGuest addGuestUseCase;
  final FetchEmployee fetchEmployeeUseCase;
  GuestBloc(this.firestore, this.addGuestUseCase, this.fetchEmployeeUseCase) : super(GuestInitial()) {
    on<SubmitGuestEvent>((event, emit) async {
      emit(FormSubmitting());
      try {
        await addGuestUseCase(event.guest);
        emit(GuestSuccess(message: 'Tamu berhasil ditambahkan'));
      } catch (e) {
        emit(GuestError(e.toString()));
      }
    });
    on<LoadEmployeesEvent>((event, emit) async {
      emit(EmployeesLoading());
      try {
        final employees = await fetchEmployeeUseCase();
        emit(GuestLoaded(employees));
      } catch (e) {
        emit(GuestError(e.toString()));
      }
    });
  }
}
