import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
class article extends StatefulWidget {
  const article({super.key});

  @override
  State<article> createState() => _articleState();
}

class _articleState extends State<article> {
  String title = "";
  String content = "";
  late ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
     title = args['title'];
     content = args['content'];
    }
  @override
  Widget build(BuildContext context) {
    double fullwidth = MediaQuery.of(context).size.width;
    double fullheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 15),
            width:fullwidth*0.95,
            height: fullheight,
            alignment: Alignment.center,
            child: Markdown(
              data: content,
              controller: scrollController,
              imageBuilder: (uri, title, alt) {
                return Image.network(uri.toString());
              },
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                p: TextStyle(fontSize: 20),
              ),
            )),
        ),
      ),
    );
  }
}
