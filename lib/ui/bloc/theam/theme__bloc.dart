import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../shared/constants/constant.dart';

part 'theme__event.dart';
part 'theme__state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeEvent>((event, emit) {
      if(event is InitialThemeEvent){
        if(sharedPreferences?.getString("them") =="Dark"){
          emit(ThemeDark(ThemeData.dark()));
        }
        else{
          emit(ThemeLight(ThemeData.light()));
        }

      }
      else if(event is DarkThemeEvent){
        sharedPreferences!.setString("them", "Dark");
        emit(ThemeDark(ThemeData.dark()));

      }
      else if(event is LightThemeEvent){
        sharedPreferences!.setString("them", "Light");
        emit(ThemeLight(ThemeData.light()));
      }
    });
  }
}
