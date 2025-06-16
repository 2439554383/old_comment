// providers.dart
import 'package:comment1/view_model/button_viewmodel.dart';
import 'package:comment1/view_model/chat_viewmodel.dart';
import 'package:comment1/view_model/content_viewmodel.dart';
import 'package:comment1/view_model/gridview_viewmodel.dart';
import 'package:comment1/view_model/hospital_viewmodel.dart';
import 'package:comment1/view_model/mainpage_viewmodel.dart';
import 'package:comment1/view_model/mine_viewmodel.dart';
import 'package:comment1/view_model/overlay_viewmodel.dart';
import 'package:comment1/view_model/pageview_viewmodel.dart';
import 'package:comment1/view_model/textfield_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/aiitem_viewmodel.dart';
import '../view_model/filelist_viewmodel.dart';
import '../view_model/listview_viewmodel.dart';

Widget buildAppWithProviders(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => overlay_viewmodel()),
      ChangeNotifierProvider(create: (_) => listview_viewmodel()),
      ChangeNotifierProvider(create: (_) => button_viewmodel()),
      ChangeNotifierProvider(create: (_) => textfield_viewmodel()),
      ChangeNotifierProvider(create: (_) => pageview_viewmodel()),
      ChangeNotifierProvider(create: (_) => gridview_viewmodel()),
      ChangeNotifierProvider(create: (_) => filelist_viewmodel()),
      ChangeNotifierProvider(create: (_) => mainpage_viewmodel()),
      ChangeNotifierProvider(create: (_) => hospital_viewmodel()),
      ChangeNotifierProvider(create: (_) => chat_viewmodel()),
      ChangeNotifierProvider(create: (_) => mine_viewmodel()),
      ChangeNotifierProvider(create: (_) => content_viewmodel()),
      ChangeNotifierProvider(create: (_) => aiitem_viewmodel()),
      // 其他 provider ...
    ],
    child: child,
  );
}
