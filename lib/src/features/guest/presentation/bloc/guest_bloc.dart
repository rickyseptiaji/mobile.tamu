import 'package:bloc/bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  final FirebaseFirestore firestore;
  GuestBloc(this.firestore) : super(const GuestInitial()) {
    on<SubmitGuestEvent>((event, emit) async {
      emit(const GuestLoading());
      try {
        await firestore.collection('guests').add({
          'companyName': event.companyName,
          'fullName': event.fullName,
          'email': event.email,
          'countryCode': event.countryCode,
          'phone': event.phone,
          'toEmployee': event.toEmployee,
          'description': event.description,
          'timestamp': FieldValue.serverTimestamp(),
        });
        emit(const GuestSuccess("Data tamu berhasil dikirim"));
      } catch (e) {
        emit(GuestError(e.toString()));
      }
    });
    on<LoadEmployeesEvent>((event, emit) async {
      emit(const GuestLoading());
      try {
        final querySnapshot = await firestore.collection('employees').get();
        final employees = querySnapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList();
        emit(GuestLoaded(employees));
      } catch (e) {
        emit(GuestError(e.toString()));
      }
    });
  }
}
