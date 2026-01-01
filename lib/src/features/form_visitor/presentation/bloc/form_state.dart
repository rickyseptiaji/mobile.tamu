enum FormVisitorStatus { initial, loading, success, failure }
class FormVisitorState {
  final FormVisitorStatus status;
  final String? message;
  final String? error;

  const FormVisitorState({
    this.status = FormVisitorStatus.initial,
    this.message,
    this.error,
  });

  FormVisitorState copyWith({
    FormVisitorStatus? status,
    String? message,
    String? error,
  }) {
    return FormVisitorState(
      status: status ?? this.status,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}