import 'dart:async';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthState.unknown()) {
    on<AuthStarted>(_onStarted);
    on<SubmitLoginEvent>(_onLogin);
    on<SubmitRegisterEvent>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
  }

  void _onStarted(AuthStarted event, Emitter<AuthState> emit) {
    final user = repository.getCurrentUser();
    if (user != null) {
      emit(AuthState.authenticated(user));
    } else {
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> _onLogin(SubmitLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    try {
      await repository.login(event.email, event.password);

      final user = repository.getCurrentUser();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.failure('Login failed'));
      }
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onRegister(
    SubmitRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    try {
      await repository.register(
        event.email,
        event.password,
        event.fullName,
        event.companyName,
        event.countryCode,
        event.phone,
      );

      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    emit(AuthState.unauthenticated());
  }
}
