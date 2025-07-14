import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_gridview_viewmodel.dart';
import 'package:path_provider/path_provider.dart';

class openmember_viewmodel extends ChangeNotifier{
   Color _bgcolor = Colors.grey;
   int _current_index = 0;

   int get current_index => _current_index;

  set current_index(int value) {
    _current_index = value;
    notifyListeners();
  }

  Color get bgcolor => _bgcolor;

  set bgcolor(Color value) {
    _bgcolor = value;
    notifyListeners();
  }
}