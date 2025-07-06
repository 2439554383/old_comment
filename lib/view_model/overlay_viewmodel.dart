import 'package:comment1/models/overlay_model.dart';
import 'package:flutter/cupertino.dart';

class overlay_viewmodel extends ChangeNotifier{
  final overlay_model _overlay_model = overlay_model();
  var _isload = false;

  get isload => _isload;

  set isload(value) {
    _isload = value;
    print(_isload);
    notifyListeners();
  }
  get isvisiable => _overlay_model.isvisiable;
  get isoverlay => _overlay_model.isoverlay;
  switch_windows(bool isvisiable){
    _overlay_model.isvisiable = isvisiable;
    notifyListeners();
}
  open_overlay(bool isoverlay){
    _overlay_model.isoverlay = isoverlay;
    notifyListeners();
  }
}