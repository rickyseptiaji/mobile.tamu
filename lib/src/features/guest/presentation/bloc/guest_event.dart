import 'package:equatable/equatable.dart';

abstract class GuestEvent extends Equatable {
  const GuestEvent();

  @override
  List<Object> get props => [];
}

class SubmitGuestEvent extends GuestEvent {
  final String companyName;
  final String fullName;
  final String email;
  final String countryCode;
  final String phone;
  final String toEmployee;
  final String description;

  const SubmitGuestEvent({
    required this.companyName,
    required this.fullName,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.toEmployee,
    required this.description,
  });

  @override
  List<Object> get props => [
        companyName,
        fullName,
        email,
        countryCode,
        phone,
        toEmployee,
        description,
      ];
}
class LoadEmployeesEvent extends GuestEvent {}