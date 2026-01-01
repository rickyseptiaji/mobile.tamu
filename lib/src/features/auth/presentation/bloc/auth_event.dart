abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class SubmitLoginEvent extends AuthEvent {
  final String email;
  final String password;

  SubmitLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthLogoutRequested extends AuthEvent {}
class SubmitRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String companyName;
  final String countryCode;
  final String phone;

  SubmitRegisterEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.companyName,
    required this.countryCode,
    required this.phone,
  });
}