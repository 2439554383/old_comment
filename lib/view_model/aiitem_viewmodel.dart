import 'package:flutter/material.dart';
import '../models/aiiten_model.dart';
class aiitem_viewmodel extends ChangeNotifier{
  aiitem_model _aiitem_model = aiitem_model();

  List get describe_list => _aiitem_model.describe_list;

  set describe_list(List value) {
    _aiitem_model.describe_list = value;
  }


  List get title_list => _aiitem_model.title_list;

  set title_list(List value) {
    _aiitem_model.title_list = value;
  }

  List get type_list => _aiitem_model.type_list;

  set type_list(List value) {
    _aiitem_model.type_list = value;
  }
  List get icon_list => _aiitem_model.icon_list;

  set icon_list(List value) {
    _aiitem_model.icon_list = value;
  }
}