import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SubmitRegisterEvent extends RegisterEvent {
  final String email;
  final String fullName;
  final String companyName;
  final String countryCode;
  final String phone;
  final String password;

  const SubmitRegisterEvent({
    required this.email,
    required this.fullName,
    required this.companyName,
    required this.countryCode,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        fullName,
        companyName,
        countryCode,
        phone,
        password,
      ];
}