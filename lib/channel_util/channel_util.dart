import 'package:flutter/services.dart';

class NativeChannel {
  static const MethodChannel _channel = MethodChannel('com.example.message');

  static Future<void> sendMessage(String message) async {
    try {
      await _channel.invokeMethod('printMessage', {'msg': message});
    } on MissingPluginException catch (_) {
      print('当前FlutterEngine未注册方法实现');
    } on PlatformException catch (e) {
      print('通信失败: ${e.message}');
    }
  }
}