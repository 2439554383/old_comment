import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/content_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class content_viewmodel extends ChangeNotifier{
  content_model _content_model =content_model();
  String get content =>_content_model.content;
  List get contentlist => _content_model.contentlist;
  set contentlist(List list){
    _content_model.contentlist  = list;
    notifyListeners();
  }
  post_content(String content) async{
    final sp = await SharedPreferences.getInstance();
    final code = sp.getString("code");
    _content_model.contentlist= await http_api().post_content("http://139.196.235.10:8005/comment/post_content/",content,code!);
  }
}