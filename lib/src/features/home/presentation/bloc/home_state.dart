abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final String message;
  HomeSuccess({required this.message});
}
class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}
class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> guest;
  HomeLoaded(this.guest);
}
