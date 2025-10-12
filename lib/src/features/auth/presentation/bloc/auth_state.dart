// Auth
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}
class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}

class AuthAuthenticated extends AuthState {
  final String token;
  AuthAuthenticated(this.token);
}
class AuthUnauthenticated extends AuthState {}

