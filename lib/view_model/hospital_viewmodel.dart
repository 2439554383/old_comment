import 'dart:io';

import 'package:comment1/api/http_api.dart';
import 'package:comment1/models/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class hospital_viewmodel extends ChangeNotifier{
  hospital_model _hospital_model = hospital_model();
  List get hospital_list => _hospital_model.hospital_List;
  get text_list => _hospital_model.text_list;
  set hospital_list(List list){
    _hospital_model.hospital_List = list;
    notifyListeners();
  }
  get_excel(String url,String name) async{
    final directory= await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/$name");
    print(file);
    final isexist = await file.exists();
    if(isexist){
      print("已经存在文件，直接打开");
      OpenFile.open(file.path);
    }
    else{
      final response = await http_api().get_excel(url,name);
    }
  }
  get_list() async{
    final response = await http_api().get_list("http://139.196.235.10:8005/comment/get_hospitallist/");
    _hospital_model.hospital_List = response;
    notifyListeners();
  }
}