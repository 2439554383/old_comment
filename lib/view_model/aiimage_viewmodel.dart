import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/aiimage_model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
class aiimage_viewmodel extends ChangeNotifier{
  aiimage_model  _aiimage_model = aiimage_model();
  get text=>_aiimage_model.text;
  get hinttext =>_aiimage_model.hinttext;
  get image=>_aiimage_model.image;
  get ww=>_aiimage_model.ww;
  set ww(var ww){
    _aiimage_model.ww = ww;
    notifyListeners();
  }
  set text(var text){
    _aiimage_model.text = text;
    notifyListeners();
  }
  set hinttext(var hinttext){
    _aiimage_model.hinttext = hinttext;
    notifyListeners();
  }
  set image(var image){
    _aiimage_model.image = image;
    notifyListeners();
  }
  post_aiimage(var text) async{
    _aiimage_model.image = await http_api().post_aiimage("http://139.196.235.10:8005/comment/get_aiimage/", text);
    if(_aiimage_model.image !=null){
      notifyListeners();
      return _aiimage_model.image;
    }
    else{
      return Future.error("error");
    }

  }
  clear(){
    _aiimage_model.text = null;
    _aiimage_model.image= null ;
    _aiimage_model.hinttext = "告诉我你想生成什么样的图片哦";
    _aiimage_model.ww= Text("我是ai图片");
  }
}