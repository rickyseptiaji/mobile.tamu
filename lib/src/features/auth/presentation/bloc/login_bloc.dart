import 'package:buku_tamu/src/features/auth/domain/usecase/save_token.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/login_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SaveToken saveTokenUseCase;
  final FirebaseAuth firebaseAuth;

  LoginBloc(this.firebaseAuth, this.saveTokenUseCase) : super(LoginInitial()) {
    on<SubmitLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final res = await firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final token = await res.user?.getIdToken();
        if (token != null) {
          await saveTokenUseCase(token);
        }

        emit(LoginSuccess('User logged in successfully'));
      } on FirebaseAuthException catch (e) {
        emit(LoginError(e.message ?? 'An unknown error occurred'));
      }
    });

    on<CheckAuthEvent>((event, emit) async {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        emit(LoginAuthenticated());
      } else {
        emit(LoginUnauthenticated());
      }
    });

    on<LogoutEvent>((event, emit) async {
      await firebaseAuth.signOut();
      emit(LoginUnauthenticated());
    });
  }
}
