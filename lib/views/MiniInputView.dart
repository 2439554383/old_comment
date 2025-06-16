import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class MiniInputView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  MiniInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('输入文字')),
      body: Column(
        children: [
          TextField(controller: _controller),
          ElevatedButton(
            onPressed: () {
              // 1. 可处理输入内容
              print("输入内容: ${_controller.text}");

              // 2. 返回上一个应用（调用平台通道或系统 intent）
              SystemNavigator.pop(); // 或使用原生跳转 intent

              // 3. 可选：自动关闭悬浮窗
              FlutterOverlayWindow.closeOverlay();
            },
            child: const Text("完成"),
          )
        ],
      ),
    );
  }
}
