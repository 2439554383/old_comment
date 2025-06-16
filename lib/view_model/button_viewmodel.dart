import 'package:comment1/models/button_model.dart';
import 'package:flutter/material.dart';
class button_viewmodel extends ChangeNotifier{
  button_model _button_model = button_model();
  get button_color => _button_model.button_color;
  switch_button_color(Color color){
    _button_model.button_color = color;
    notifyListeners();
  }
}