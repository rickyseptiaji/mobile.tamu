
import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';

abstract class GuestEvent {}

class SubmitGuestEvent extends GuestEvent {
  final GuestEntity guest;
  SubmitGuestEvent(this.guest);
}

class LoadEmployeesEvent extends GuestEvent {}