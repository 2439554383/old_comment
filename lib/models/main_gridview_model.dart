import 'package:flutter/material.dart';

class main_gridview_model {
  List<Widget> iconlist = [
    Icon(Icons.baby_changing_station,color: Colors.orange,size: 30,),
    Icon(Icons.safety_check,color: Colors.orange,size: 30,),
    Icon(Icons.dangerous_outlined,color: Colors.orange,size: 30,),
    Icon(Icons.safety_check,color: Colors.orange,size: 30,),
    Icon(Icons.vaccines_outlined,color: Colors.orange,size: 30,),
    Icon(Icons.nat_rounded,color: Colors.orange,size: 30,),
    Icon(Icons.yard_outlined,color: Colors.orange,size: 30,),
    Icon(Icons.kayaking_outlined,color: Colors.orange,size: 30,),
  ];
  List<String> textlist = [
    "通信",
    "资料",
    "验证",
    "我的",
    "中心",
    "商城",
    "钱包",
    "骑手",
  ];
  main_gridview_model({iconlist,textlist});
}