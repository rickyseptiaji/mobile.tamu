abstract class GuestState {}

class GuestInitial extends GuestState {}

class GuestLoading extends GuestState {}

class GuestSuccess extends GuestState {
  final String message;
  GuestSuccess({required this.message});
}

class GuestError extends GuestState {
  final String error;
  GuestError(this.error);
}

class GuestLoaded extends GuestState {
  final List<Map<String, dynamic>> employees;
  GuestLoaded(this.employees);
}

class EmployeesLoading extends GuestState {}

class FormSubmitting extends GuestState {}

class FormError extends GuestState {
  final String error;
  FormError(this.error);
}
