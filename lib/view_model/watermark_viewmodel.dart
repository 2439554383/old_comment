import 'dart:io';

import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/watermark_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
class watermark_viewmodel extends ChangeNotifier{
   watermark_model _watermark_model =  watermark_model();
   get post_video => _watermark_model.post_video;
   get isinit => _watermark_model.isinit;
   get imagePicker => _watermark_model.imagePicker;
   Widget get future_widget => _watermark_model.future_widget;
   get download_video => _watermark_model.download_video;
   set post_video(var post_video){
     _watermark_model.post_video = post_video;
     notifyListeners();
   }
   set future_widget(Widget future_widget){
     _watermark_model.future_widget = future_widget;
   }
   set isinit(var isinit){
     _watermark_model.isinit = isinit;
     notifyListeners();
   }
   set download_video(var download_video){
     _watermark_model.download_video = download_video;
     notifyListeners();
   }
   remove_watermark(var text) async{
     download_video = await http_api().post_aiimage("http://139.196.235.10:8005/comment/get_unmarkvideo/", text);
     print(download_video);
     notifyListeners();
     if(download_video!=null){
       print(11111);
       return download_video;
     }
     else{
       return Future.error("error");
     }
   }
   clear(){
     _watermark_model.future_widget = Text("我是你的去水印助手");
   }
   // picker_video() async{
   //   var video = await imagePicker.pickVideo(source: ImageSource.gallery);
   //   if(video!=null){
   //     print(video.path);
   //     File video_file = File(video.path);
   //     post_video = video_file;
   //     videoPlayerController = VideoPlayerController.file(post_video);
   //     await videoPlayerController.initialize();
   //     isinit = true;
   //     notifyListeners();
   //   }
   // }
}