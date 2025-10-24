abstract class FormVisitorState {}

class FormVisitorInitial extends FormVisitorState {}

class FormVisitorLoading extends FormVisitorState {}

class FormVisitorSuccess extends FormVisitorState {
  final String message;
  FormVisitorSuccess({required this.message});
}

class FormVisitorError extends FormVisitorState {
  final String error;
  FormVisitorError(this.error);
}
