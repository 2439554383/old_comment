import 'package:comment1/api/http_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class voice_clone_viewmodel extends ChangeNotifier{
  final voiceList = [];
  getVoice() async {
    try{
      final url = "";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if(response.statusCode ==200){
        
      }
      else{

      }
    }
    catch(e){
      print(e);
    }
  }
}