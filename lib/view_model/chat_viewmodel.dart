import 'dart:async';
import 'dart:io';

import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class chat_viewmodel extends ChangeNotifier{
  StreamController _streamController = StreamController.broadcast()..close();
  chat_model _chat_model = chat_model();
  String get res_text => _chat_model.res_text;
  bool get hasimage => _chat_model.hasimage;
  bool get isstart => _chat_model.isstart;
  StreamController get streamcontroller => _streamController;
  set res_text(String sr){
    _chat_model.res_text = sr;
    notifyListeners();
  }
  set hasimage(bool hasimage){
    _chat_model.hasimage = hasimage;
    if(hasimage==true){
      notifyListeners();
    }
  }
  set isstart(bool isstart){
    _chat_model.isstart = isstart;
    notifyListeners();
  }

  post_image(String text,String image_path,String type) async{
      _streamController = StreamController.broadcast();
      final response = await http_api().postimage_api("http://124.70.183.83:8005/comment/get_image/", text, image_path,type,_streamController);
      notifyListeners();}

  post_text(String text,String type) async{
    _streamController = StreamController.broadcast();
    final response = await http_api().post_text("http://124.70.183.83:8005/comment/get_text/", text,type,_streamController);
    notifyListeners();}
}