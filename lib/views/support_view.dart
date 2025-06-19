import 'package:flutter/material.dart';
class support_view extends StatefulWidget {
  const support_view({super.key});

  @override
  State<support_view> createState() => _support_viewState();
}

class _support_viewState extends State<support_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("客服中心"),
      ),
      body: Center(
        child: Text("微信号：abc18268878",style: TextStyle(fontSize: 25,color: Colors.grey[700]),),
      ),
    );
  }
}
