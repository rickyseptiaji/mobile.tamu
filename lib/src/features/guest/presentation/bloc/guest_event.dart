import 'package:equatable/equatable.dart';

abstract class GuestEvent extends Equatable {
  const GuestEvent();

  @override
  List<Object?> get props => [];
}

class GuestSubmitEvent extends GuestEvent {
  final String company;
  final String name;
  final String email;
  final String countryCode;
  final String phone;
  final String description;
  final String? to;

  const GuestSubmitEvent({
    required this.company,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.description,
    this.to,
  });

  @override
  List<Object?> get props => [company, name, email, phone, description, to];
}
