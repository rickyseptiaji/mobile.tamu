abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess(this.message);
}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}
class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginAuthenticated extends LoginState {}
class LoginUnauthenticated extends LoginState {}
