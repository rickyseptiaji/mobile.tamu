import 'package:buku_tamu/src/features/form_visitor/domain/usecases/add_visitor_usecase.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_event.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormVisitorBloc extends Bloc<FormVisitorEvent, FormVisitorState> {
  final AddVisitorUsecase addVisitorUsecase;

  FormVisitorBloc(this.addVisitorUsecase) : super(FormVisitorInitial()) {
    on<SubmitVisitorEvent>((event, emit) async {
      emit(FormVisitorLoading());
      try {
        final res = await addVisitorUsecase(event.employeeId, event.description);
        emit(FormVisitorSuccess(message: res));
      } catch (e) {
        emit(FormVisitorError(e.toString()));
      }
    });
  }
}
