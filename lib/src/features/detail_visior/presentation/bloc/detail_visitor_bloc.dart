import 'package:buku_tamu/src/features/detail_visior/domain/usecases/detailvisitor_usecase.dart';
import 'package:buku_tamu/src/features/detail_visior/presentation/bloc/detail_visitor_event.dart';
import 'package:buku_tamu/src/features/detail_visior/presentation/bloc/detail_visitor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailVisitorBloc extends Bloc<DetailVisitorEvent, DetailVisitorState> {
  final DetailvisitorUsecase detailvisitorUsecase;
  DetailVisitorBloc(this.detailvisitorUsecase) : super(DetailVisitorInitial()) {
    on<LoadDetailVisitor>((event, emit) async {
      emit(DetailVisitorLoading());
      try {
        final res = await detailvisitorUsecase.fetchDetailVisitor(event.id);
        emit(DetailVisitorLoaded(res));
      } catch (e) {
        emit(DetailVisitorError('Terjadi Kesalahan'));
      }
    });
  }
}
