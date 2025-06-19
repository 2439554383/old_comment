import 'package:comment1/models/list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import '../api/http_api.dart';
class listview_viewmodel extends ChangeNotifier {
  list_view_model _list_view_model = list_view_model();

  List get type_list => _list_view_model.type_list;
  List get type_overlay_list => _list_view_model.type_overlay_list;
  List get comment_list => _list_view_model.comment_list;
  bool get isloadlist => _list_view_model.isloadlist;

  set type_list(List list){
    _list_view_model.type_list = list;
    notifyListeners();
  }
  set isloadlist(bool isloadlist){
    _list_view_model.isloadlist = isloadlist;
    notifyListeners();
  }
  set type_overlay_list(List list){
    _list_view_model.type_overlay_list = list;
    notifyListeners();
  }
  get_list(String code) async{
    final data =  await http_api().all_api("http://139.196.235.10:8005/comment/get_listmodel/",code);
    if(data["status"] ==true){
      print("获取列表中");
      _list_view_model.type_list  = data['type_list'];
      _list_view_model.type_overlay_list  = data['type_overlay_list'];
      _list_view_model.isloadlist = true;
      print("获取列表成功");
      print(data['type_list']);
      notifyListeners();
    }
    else{
      print("获取列表失败！！！！！！！！！！！！！");
    }

  }
  // overlay_list(){
  //   _list_view_model.type_overlay_list.clear();
  //   _list_view_model.count_overlay_list.clear();
  //   for(int i =0;i<type_list.length;i++){
  //     if(_list_view_model.type_list[i][3] == true){
  //       _list_view_model.type_overlay_list.add(_list_view_model.type_list[i]);
  //     }
  //   }
  //   for(int i =0;i<count_list.length;i++){
  //     if(_list_view_model.count_list[i][3] == true){
  //       _list_view_model.count_overlay_list.add(_list_view_model.count_list[i]);
  //     }
  //   }
  //   notifyListeners();
  // }
  overlay_list(){

  }
  switch_type_isset(bool istrue,int index) async{
    _list_view_model.type_list[index][2] = istrue;
    notifyListeners();
  }
  switch_type_isset1(bool istrue,int index) async{
    _list_view_model.type_overlay_list[index][3] = istrue;
    if(istrue == true){
      _list_view_model.comment_list.add(type_overlay_list[index][1]);
    }
    else{
      _list_view_model.comment_list.remove(type_overlay_list[index][1]);
    }
    print(_list_view_model.comment_list);
    notifyListeners();
  }
  reset(){
    for(int i = 0; i<_list_view_model.type_overlay_list.length;i++){
      _list_view_model.type_overlay_list[i][3] = false;
    }
    comment_list.clear();
    notifyListeners();
  }
  switch_comfirm(String? code) async{
    await http_api().switch_api("http://139.196.235.10:8005/comment/switch_isset/",_list_view_model.type_list,code!);
    notifyListeners();
  }



}