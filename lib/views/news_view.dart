import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class news_view extends StatefulWidget {
  const news_view({super.key});

  @override
  State<news_view> createState() => _news_viewState();
}

class _news_viewState extends State<news_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.orangeAccent.withOpacity(0.1),
                      CupertinoColors.secondarySystemBackground
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment(0,0.5)
                )
            ),
            child: Text("暂未开放",style: TextStyle(fontSize: 20),)),
      ),
    );
  }
}
