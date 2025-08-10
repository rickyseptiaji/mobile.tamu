import 'package:bloc/bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  GuestBloc() : super(GuestInitialState()) {
      on<GuestSubmitEvent>(_onSubmit);
  }

  Future<void> _onSubmit(GuestSubmitEvent event, Emitter<GuestState> emit) async {
    emit(GuestLoadingState());
    try {
      await FirebaseFirestore.instance.collection('guests').add({
        'company': event.company,
        'name': event.name,
        'email': event.email,
        'countryCode': event.countryCode,
        'phone': event.phone,
        'description': event.description,
        'toEmployee': event.to,
      });
      emit(GuestSuccessState('Data submitted successfully!'));
    } catch (error) {
      emit(GuestFailureState('Failed to submit data: $error'));
    }
  }
}