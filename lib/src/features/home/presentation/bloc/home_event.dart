

abstract class HomeEvent {}

class SubmitGuestEventUser extends HomeEvent {
  final String employeeId ;
  final String description;
  SubmitGuestEventUser({required this.employeeId, required this.description});
}

class LoadGuestsEventUser extends HomeEvent {}