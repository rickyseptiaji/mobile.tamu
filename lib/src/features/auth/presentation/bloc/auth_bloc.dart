import 'package:buku_tamu/src/features/auth/domain/usecase/get_token_usecase.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/login_usecase.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/logout_usecase.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/register_usecase.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetTokenUseCase getTokenUseCase;
  final LoginUsecase loginUserUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUserUseCase;

  AuthBloc(
    this.loginUserUseCase,
    this.logoutUseCase,
    this.getTokenUseCase,
    this.registerUserUseCase,
  ) : super(AuthInitial()) {
    on<SubmitLoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final res = await loginUserUseCase(event.email, event.password);
        emit(AuthAuthenticated(res));
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(error: e.message ?? 'An unknown error occurred'));
      }
    });

    on<CheckAuthEvent>((event, emit) async {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        emit(AuthAuthenticated(currentUser));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LogoutEvent>((event, emit) async {
      await logoutUseCase();
      emit(AuthUnauthenticated());
    });

    on<SubmitRegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final res = await registerUserUseCase(
          event.email,
          event.password,
          event.fullName,
          event.companyName,
          event.countryCode,
          event.phone,
        );
        emit(AuthSuccess(res));
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(error: e.message ?? 'An unknown error occurred'));
      }
    });
  }
}
