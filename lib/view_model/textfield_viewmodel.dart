import 'dart:async';

import 'package:comment1/models/textfield_model.dart';
import 'package:comment1/view_model/listview_viewmodel.dart';
import 'package:flutter/material.dart';

import '../api/http_api.dart';
class textfield_viewmodel extends ChangeNotifier{
  textfield_model _textfield_model = textfield_model();
  StreamController _streamController = StreamController.broadcast()..close();
  StreamController get streamcontroller => _streamController;
  String get content => _textfield_model.content;
  bool get isstart => _textfield_model.isstart;
  set content(String content){
    _textfield_model.content = content;
    notifyListeners();
  }
  set isstart(bool isstart){
    _textfield_model.isstart = isstart;
    notifyListeners();
  }
  Future<String> get_comment(String text,List comment_list1,String count)async{
    print("comment_list111$comment_list1");
    _streamController = StreamController.broadcast();
    content = await http_api().general_api("http://139.196.235.10:8005/comment/get_comment/", text, comment_list1,count,_streamController);
    notifyListeners();
    return content;
  }
}