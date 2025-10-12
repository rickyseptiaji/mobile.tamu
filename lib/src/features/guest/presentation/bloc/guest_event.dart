
abstract class GuestEvent {}

class SubmitGuestEvent extends GuestEvent {
  final dynamic guest;
  SubmitGuestEvent(this.guest);
}

class LoadEmployeesEvent extends GuestEvent {}