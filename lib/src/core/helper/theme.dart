import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // false = light mode

  void toggleTheme(bool value) {
    emit(value);
  }
}