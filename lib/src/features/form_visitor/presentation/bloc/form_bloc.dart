import 'package:buku_tamu/src/features/form_visitor/domain/repository/form_visitor_repository.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_event.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormVisitorBloc extends Bloc<FormVisitorEvent, FormVisitorState> {
  final FormVisitorRepository repository;

  FormVisitorBloc({required this.repository}) : super(FormVisitorState()) {
    on<SubmitVisitorEvent>(_onSubmitVisitor);
  }

  Future<void> _onSubmitVisitor(
    SubmitVisitorEvent event,
    Emitter<FormVisitorState> emit,
  ) async {
    emit(state.copyWith(status: FormVisitorStatus.loading));
    try {
      final message = await repository.addVisitor(
        event.employeeId,
        event.description,
      );

      emit(state.copyWith(status: FormVisitorStatus.success, message: message));
    } catch (e) {
      emit(
        state.copyWith(status: FormVisitorStatus.failure, error: e.toString()),
      );
    }
  }
}
