import 'package:bloc/bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_event.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  final FirebaseFirestore firestore;
  GuestBloc(this.firestore) : super(const GuestState()) {
    on<GuestCompanyChanged>((event, emit) {
      emit(state.copyWith(companyName: event.companyName));
    });

    on<GuestFullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });

    on<GuestEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<GuestPhoneChanged>((event, emit) {
      emit(state.copyWith(countryCode: event.countryCode, phone: event.phone));
    });

    on<GuestToEmployeeChanged>((event, emit) {
      emit(state.copyWith(toEmployee: event.toEmployee));
    });

    on<GuestDescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<LoadEmployees>((event, emit) async {
      emit(state.copyWith(employeesLoading: true));
      try {
        final snapshot = await firestore.collection('employees').get();
        final employees = snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            ...data, 
          };
        }).toList();

        emit(state.copyWith(employees: employees, employeesLoading: false));
      } catch (e) {
        emit(state.copyWith(employeesLoading: false));
      }
    });

    on<GuestSubmitEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));

      try {
        await FirebaseFirestore.instance.collection('guests').add({
          'companyName': state.companyName,
          'fullName': state.fullName,
          'email': state.email,
          'countryCode': state.countryCode,
          'phone': state.phone,
          'toEmployee': state.toEmployee,
          'description': state.description,
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(state.copyWith(isLoading: false, success: true));
        emit(state.copyWith(success: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });
  }
}
