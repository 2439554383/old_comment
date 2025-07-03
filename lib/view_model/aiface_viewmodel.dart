import 'dart:convert';

import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/aiface_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
class aiface_viewmodel extends ChangeNotifier {
  aiface_model _aiface_model = aiface_model();
  Widget get future_widget=> _aiface_model.future_widget;
  get old_image => _aiface_model.old_image;
  set old_image(var old_image){
    _aiface_model.old_image = old_image;
    notifyListeners();
  }
  set future_widget(Widget future_widget){
    _aiface_model.future_widget = future_widget;
    notifyListeners();
  }
  get face_image => _aiface_model.face_image;
  set face_image(var face_image){
    _aiface_model.face_image = face_image;
    notifyListeners();
  }
  get new_image => _aiface_model.new_image;
  set new_image(var new_image){
    _aiface_model.new_image = new_image;
    notifyListeners();
  }
  get old_imagefile => _aiface_model.old_imagefile;
  set old_imagefile(var old_imagefile){
    _aiface_model.old_imagefile = old_imagefile;
    notifyListeners();
  }
  get face_imagefile => _aiface_model.face_imagefile;
  set face_imagefile(var face_imagefile){
    _aiface_model.face_imagefile = face_imagefile;
    notifyListeners();
  }
  get new_imagefile => _aiface_model.new_imagefile;
  set new_imagefile(var new_imagefile){
    _aiface_model.new_imagefile = new_imagefile;
    notifyListeners();
  }
  post_aiface() async{
     final response = await http_api().post_aiface("http://139.196.235.10:8005/comment/post_aiface/", old_image,face_image);
     if(response!=null){
       print("收到图片");
       final bytes = base64Decode(response);
       _aiface_model.new_image = bytes;
       print(_aiface_model.new_image);
       notifyListeners();
       return Future.value(true);
     }
     else{
       print("没有收到图片");
       return Future.error("error");
     }
  }
}