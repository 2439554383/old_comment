import 'package:comment1/models/filelist_model.dart';
import 'package:flutter/material.dart';
import '../api/http_api.dart';
class filelist_viewmodel extends ChangeNotifier{
  filelist_model _filelist_model = filelist_model();
  List get text_list => _filelist_model.text_list;
  List get widget_list => _filelist_model.widget_list;
  List get desc_list => _filelist_model.desc_list;
  List get icon_list => _filelist_model.icon_list;
  List get type_list => _filelist_model.type_list;
  Map get file_dict  => _filelist_model.file_dict;
  set file_list(Map<String,List> dict){
    _filelist_model.file_dict = dict;
    notifyListeners();
  }
  set desc_list(List list){
    _filelist_model.desc_list = list;
    notifyListeners();
  }
  set text_list(List list){
    _filelist_model.text_list = list;
    notifyListeners();
  }
  get_filelist() async{
    _filelist_model.file_dict = await http_api().get_list("http://139.196.235.10:8005/comment/get_filelist/");
    notifyListeners();
  }
}