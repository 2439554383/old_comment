
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PrivacyPolicyCtrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
  @override
  void dispose() {
    super.dispose();
  }
  List<Map<String, dynamic>> feedbackList = [
    {"title": "功能建议", "image": "assets/personal_center/feedback_function.png"},
    {"title": "产品体验", "image": "assets/personal_center/feedback_experience.png"},
    {"title": "其他问题", "image": "assets/personal_center/feedback_other.png"},
  ];
}