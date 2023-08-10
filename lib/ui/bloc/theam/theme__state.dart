part of 'theme__bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {

}
class ThemeDark extends ThemeState {
ThemeData theme;

ThemeDark(this.theme);
}

class ThemeLight extends ThemeState {
  ThemeData theme;

  ThemeLight(this.theme);
}

