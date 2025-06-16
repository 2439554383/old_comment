import 'package:flutter/cupertino.dart';
import '../models/main_gridview_model.dart';

class main_gridview_viewmodel extends ChangeNotifier{
  main_gridview_model _main_gridview_model = main_gridview_model();
  get iconlist => _main_gridview_model.iconlist;
  get textlist => _main_gridview_model.textlist;
  changetext(String text){
    _main_gridview_model.textlist[7] = text;
    notifyListeners();
  }
}