import 'package:comment1/models/mainpage_model.dart';
import 'package:flutter/material.dart';
class mainpage_viewmodel extends ChangeNotifier{
  mainpage_model _mainpage_model= mainpage_model();
  int get current_index => _mainpage_model.current_index;
  set current_index(int current_index){
    _mainpage_model.current_index = current_index;
    notifyListeners();
  }
}