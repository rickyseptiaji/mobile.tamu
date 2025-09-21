import 'package:equatable/equatable.dart';

abstract class GuestState extends Equatable {
  const GuestState();

  @override
  List<Object> get props => [];
}

class GuestInitial extends GuestState {
  const GuestInitial();
}
class GuestLoading extends GuestState {
  const GuestLoading();
}

class GuestSuccess extends GuestState {
  final String message;
  const GuestSuccess(this.message);
}

class GuestError extends GuestState {
  final String message;

  const GuestError(this.message);

  @override
  List<Object> get props => [message];
}
class GuestLoaded extends GuestState {
  final  List<Map<String, dynamic>> employees;
  const GuestLoaded(this.employees);
  @override
  List<Object> get props => [employees];
}

