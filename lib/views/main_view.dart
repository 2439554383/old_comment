import 'dart:developer';
import 'dart:io';
import 'package:comment1/api/http_api.dart';
import 'package:comment1/view_model/listview_viewmodel.dart';
import 'package:comment1/view_model/mainpage_viewmodel.dart';
import 'package:comment1/view_model/overlay_viewmodel.dart';
import 'package:comment1/views/store_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:provider/provider.dart';
import 'hospital_view.dart';
import 'home_view.dart';
import 'mine_view.dart';
import 'news_view.dart';
class main_view extends StatefulWidget {
  const main_view({super.key});

  @override
  State<main_view> createState() => _main_viewState();
}

class _main_viewState extends State<main_view> {
  int current_index = 0;
  late mainpage_viewmodel mainpage_provider ;
  var widget_list = [
    home_view(),
    hospital_view(),
    store_view(),
    news_view(),
    mine_view(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainpage_provider = Provider.of<mainpage_viewmodel>(context,listen: false);
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<mainpage_viewmodel>(
      builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "主页"),
              BottomNavigationBarItem(icon: Icon(Icons.local_hospital),label: "医疗"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: "商品"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.news),label: "新闻"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),label: "我的"),
            ],
            currentIndex: mainpage_provider.current_index,
            onTap: (index){
                setState(() {
                  mainpage_provider.current_index = index;
                });
            },
          ),
          backgroundColor: CupertinoColors.tertiarySystemGroupedBackground,
        body: IndexedStack(index:mainpage_provider.current_index,children: widget_list)
      );
      },
    );
  }
}
