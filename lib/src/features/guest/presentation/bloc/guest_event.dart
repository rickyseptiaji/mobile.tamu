class GuestEvent {}

class GuestCompanyChanged extends GuestEvent {
  final String companyName;

 GuestCompanyChanged(this.companyName);
}

class GuestFullNameChanged extends GuestEvent {
  final String fullName;

  GuestFullNameChanged(this.fullName);
}
class GuestEmailChanged extends GuestEvent {
  final String email;

  GuestEmailChanged(this.email);
}
class GuestPhoneChanged extends GuestEvent {
  final String countryCode;
  final String phone;

  GuestPhoneChanged(this.countryCode, this.phone);
}
class GuestToEmployeeChanged extends GuestEvent {
  final String toEmployee;

  GuestToEmployeeChanged(this.toEmployee);
}
class GuestDescriptionChanged extends GuestEvent {
  final String description;

  GuestDescriptionChanged(this.description);
}
class LoadEmployees extends GuestEvent {}
class GuestSubmitEvent extends GuestEvent {}