abstract class DetailVisitorState {}

class DetailVisitorInitial extends DetailVisitorState {}
class DetailVisitorLoading extends DetailVisitorState {}
class DetailVisitorLoaded extends DetailVisitorState {
  final Map<String,dynamic>? data;

  DetailVisitorLoaded(this.data);
}

class DetailVisitorError extends DetailVisitorState {
  final String error;
  DetailVisitorError(this.error);
}
