import 'package:buku_tamu/src/features/auth/domain/usecase/register_usecase.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_event.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegister);
  }
  Future<void> _onRegister(RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final user = await _registerUseCase.register(event.email, event.password);
      emit(RegisterSuccess(user: user));
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}