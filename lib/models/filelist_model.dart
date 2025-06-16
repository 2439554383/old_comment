import 'package:comment1/views/ailearn.dart';
import 'package:comment1/views/business_view.dart';
import 'package:comment1/views/hottext.dart';
import 'package:comment1/views/maobook.dart';
import 'package:comment1/views/menu.dart';
import 'package:comment1/views/olddate.dart';
import 'package:comment1/views/specialmethod.dart';
import 'package:comment1/views/startaccount_view.dart';
import 'package:flutter/material.dart';
class filelist_model{
  Map file_dict = {};
  List text_list = [
    "抖音起号",
    "AI智能体学习资料",
    "小红书爆款文案",
    "商业模式大全",
    "毛选商业解读",
    "养生菜谱",
    "小偏方",
    "老黄历",
  ];
  List type_list = [
    "抖音起号",
    "ai学习资料",
    "小红书爆款文案",
    "商业模式",
    "毛选商业解读",
    "养生菜谱",
    "小偏方",
    "老黄历",
  ];
  List desc_list = [
    "新手快速起号技巧，助你打造热门抖音账号",
    "掌握AI智能体知识，打造高效自动化助手",
    "精选高点赞小红书文案，提升转化和互动",
    "全面解读主流商业模式，开启创业新思维",
    "从毛选看商业本质，学习老一辈的智慧",
    "推荐每日养生菜谱，健康饮食科学搭配",
    "流传实用的小偏方，应对日常小病不求人",
    "每日老黄历查询，宜忌参考运势指引生活",
  ];

  List<Icon> icon_list = [
    Icon(Icons.local_fire_department, color: Colors.redAccent, size: 30),         // 抖音起号 - 火热
    Icon(Icons.psychology, color: Colors.deepPurple, size: 30),                   // AI学习资料 - 知识脑袋
    Icon(Icons.text_snippet, color: Colors.pinkAccent, size: 30),                 // 小红书文案 - 文案相关
    Icon(Icons.business_center, color: Colors.teal, size: 30),                    // 商业模式 - 商业包
    Icon(Icons.school, color: Colors.indigo, size: 30),                           // 毛选解读 - 学习/哲理
    Icon(Icons.restaurant_menu, color: Colors.orangeAccent, size: 30),           // 养生菜谱 - 菜单
    Icon(Icons.healing, color: Colors.green, size: 30),                           // 小偏方 - 健康医疗
    Icon(Icons.wb_sunny, color: Colors.amber, size: 30),                          // 老黄历 - 阳光日历
  ];
  List widget_list = [
    startaccount(),
    ailearn(),
    hottext(),
    business_view(),
    maobook(),
    menu(),
    specialmethod(),
    olddate(),
  ];
}