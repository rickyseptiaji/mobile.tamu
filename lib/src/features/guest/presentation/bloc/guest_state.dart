import 'package:equatable/equatable.dart';

abstract class GuestState extends Equatable {
  const GuestState();

  @override
  List<Object?> get props => [];

}

class GuestInitialState extends GuestState {}
class GuestLoadingState extends GuestState {}
class GuestSuccessState extends GuestState {
  final String message;

  const GuestSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
class GuestFailureState extends GuestState {
  final String error;

  const GuestFailureState(this.error);

  @override
  List<Object?> get props => [error];
}