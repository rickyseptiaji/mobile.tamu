import 'package:buku_tamu/src/features/auth/presentation/bloc/login_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth firebaseAuth;

  LoginBloc(this.firebaseAuth) : super(LoginInitial()) {
    on<SubmitLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess('User logged in successfully'));
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
