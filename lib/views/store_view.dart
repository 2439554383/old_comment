import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class store_view extends StatefulWidget {
  const store_view({super.key});

  @override
  State<store_view> createState() => _store_viewState();
}

class _store_viewState extends State<store_view> {
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
                    end: Alignment(0, 0.5)
                )
            ),
            child: Text("暂未开放",style: TextStyle(fontSize: 20),)),
      ),
    );
  }
}
