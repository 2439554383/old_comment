import 'dart:io';

import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/voice_clone_model.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
class voice_clone_viewmodel extends ChangeNotifier{
  voice_clone_model _voice_clone_model = voice_clone_model();
  AudioPlayer _player = AudioPlayer();
  AudioPlayer _player1 = AudioPlayer();
  get get_voice => _voice_clone_model.get_voice;
  Widget get future_widget => _voice_clone_model.future_widget;
  AudioPlayer get player => _player;
  AudioPlayer get player1 => _player1;
  get post_voice => _voice_clone_model.post_voice;
  get hasdata => _voice_clone_model.hasdata;
  get text => _voice_clone_model.text;

  set get_voice(var get_voice){
    _voice_clone_model.get_voice = get_voice;
    notifyListeners();
  }
  set future_widget(Widget future_widget){
    _voice_clone_model.future_widget = future_widget;
    notifyListeners();
  }
  set post_voice(var post_voice){
    _voice_clone_model.post_voice = post_voice;
    notifyListeners();
  }
  set hasdata(var hasdata){
    _voice_clone_model.hasdata = hasdata;
    notifyListeners();
  }
  set text(var text){
    _voice_clone_model.text = text;
    notifyListeners();
  }

  pick_audio() async{
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3','wav']
    );
    if(result!=null){
      final path = result.files.single.path;
      File file = File(path!);
      _voice_clone_model.post_voice = path;
      _voice_clone_model.hasdata = true;
      notifyListeners();
      print("获取到音频地址$path");
    }
  }
  clear(){
    _voice_clone_model.future_widget = Text("您的合成音频");
    _voice_clone_model.hasdata = false;
  }
  post_audio(var text) async{
    final response = await http_api().post_audio("http://139.196.235.10:8005/comment/post_audio/", text,post_voice);
    if(response!=null){
      _voice_clone_model.get_voice = response;
      await _player1.setUrl(_voice_clone_model.get_voice);
      notifyListeners();
      return response;
    }
    else{
      return Future.error("error");
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _player.dispose();
    _player1.dispose();
    super.dispose();
  }
}