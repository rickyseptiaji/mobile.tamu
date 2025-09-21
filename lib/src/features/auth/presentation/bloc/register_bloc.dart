import 'package:buku_tamu/src/features/auth/presentation/bloc/register_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  RegisterBloc(this.firebaseAuth, this.firestore) : super(RegisterInitial()) {
    on<SubmitRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
       final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
            final uuid = userCredential.user?.uid;
            if (uuid != null) {
             await firestore.collection('users').doc(uuid).set({
              'id': uuid,
              'name': event.fullName,
              'companyName': event.companyName,
              'countryCode': event.countryCode,
              'phoneNumber': event.phone,
              'createdAt': FieldValue.serverTimestamp(),
            });
            }
        emit(RegisterSuccess('User registered successfully'));
      } catch (e) {
        emit(RegisterError(e.toString()));
      }
    });
  }
} 