import 'package:comment1/models/gridview_model.dart';
import 'package:flutter/material.dart';
class gridview_viewmodel extends ChangeNotifier{
  gridview_model _gridview_model = gridview_model();
  get icon_list=>_gridview_model.icon_list;
  get text_list=>_gridview_model.text_list;
}