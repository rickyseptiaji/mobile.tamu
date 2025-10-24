abstract class FormVisitorEvent {}

class SubmitVisitorEvent extends FormVisitorEvent {
  final String employeeId;
  final String description;
  SubmitVisitorEvent({required this.employeeId, required this.description});
}
