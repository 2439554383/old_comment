import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/mine_model.dart';
import 'package:flutter/material.dart';
class mine_viewmodel extends ChangeNotifier{
  mine_model _mine_model = mine_model();
  String get code => _mine_model.code;
  bool get isactive => _mine_model.isactive;
  set code(String code){
    _mine_model.code = code;
    notifyListeners();
  }
  set isactive(bool isactive){
    _mine_model.isactive = isactive;
    notifyListeners();
  }
  post_code(String code) async{
    final response = await http_api().post_code("http://124.70.183.83:8005/comment/get_code/",code);
    _mine_model.isactive = true;
    notifyListeners();
  }
}