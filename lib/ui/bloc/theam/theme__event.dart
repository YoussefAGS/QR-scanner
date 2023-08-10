part of 'theme__bloc.dart';

@immutable
abstract class ThemeEvent {}
class InitialThemeEvent extends ThemeEvent{}
class DarkThemeEvent extends ThemeEvent{}
class LightThemeEvent extends ThemeEvent{}