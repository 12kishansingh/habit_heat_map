import 'package:flutter/material.dart';
import 'package:habit_heat_map/darkmode.dart';
import 'package:habit_heat_map/lightmode.dart';

class ThemeProvider extends ChangeNotifier{
  //initially light mode
  ThemeData _themeData=lightmode;
  // get current theme
  ThemeData get themeData=>_themeData;
  // is dark 
  bool get isdarkmode=> _themeData==darkmode;
  // set theme
  set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }
  //toggle theme
  void toggleTheme(){
    if(_themeData==lightmode){
      themeData=darkmode;
    }else{
      themeData=lightmode;
    }
  }
  
}