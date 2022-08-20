import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'theme_state.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(mode: ThemeMode.system)) {
    on<SwitchThemeEvent>(onSwitchTheme);
  }
  Future<void> onSwitchTheme(
      SwitchThemeEvent event, Emitter<ThemeState> emit) async {
    switch (state.mode) {
      case ThemeMode.dark:
        emit(state.copyWith(mode: ThemeMode.system));
        break;
      case ThemeMode.light:
        emit(state.copyWith(mode: ThemeMode.dark));
        break;
      case ThemeMode.system:
        emit(state.copyWith(mode: ThemeMode.light));
        break;
    }
  }
}
