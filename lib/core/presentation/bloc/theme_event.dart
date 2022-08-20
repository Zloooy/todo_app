part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  const ThemeEvent();
}

class SwitchThemeEvent extends ThemeEvent {
  const SwitchThemeEvent();
}
