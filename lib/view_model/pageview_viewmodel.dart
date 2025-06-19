import 'package:comment1/models/pageview_model.dart';
import 'package:flutter/material.dart';
class pageview_viewmodel extends ChangeNotifier{
  pageview_model _pageview_model = pageview_model();
  List get text_list => _pageview_model.text_list;
}