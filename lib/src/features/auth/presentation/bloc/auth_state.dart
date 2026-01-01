import 'package:buku_tamu/src/features/auth/domain/entity/auth_user.dart';

enum AuthStatus {
  unknown,
  loading,
  authenticated,
  unauthenticated,
  failure,
}

class AuthState {
  final AuthStatus status;
  final AuthUser? user;
  final String? message;

  const AuthState({
    required this.status,
    this.user,
    this.message,
  });

  factory AuthState.unknown() =>
      const AuthState(status: AuthStatus.unknown);

  factory AuthState.loading() =>
      const AuthState(status: AuthStatus.loading);

  factory AuthState.authenticated(AuthUser user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);

  factory AuthState.failure(String message) =>
      AuthState(status: AuthStatus.failure, message: message);
}
