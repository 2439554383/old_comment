import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/filelist_viewmodel.dart';
class business_view extends StatefulWidget {
  const business_view({super.key});

  @override
  State<business_view> createState() => _business_viewState();
}

class _business_viewState extends State<business_view> {
  late filelist_viewmodel filelist_provider;
  late List filelist = filelist_provider.file_dict['商业模式']!;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filelist_provider = Provider.of<filelist_viewmodel>(context,listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Consumer<filelist_viewmodel>(
        builder: (BuildContext context, value, Widget? child) {
          return Center(
              child: Column(
                  children: List.generate(filelist.length, (index){
                    return Container(
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap:(){
                                Navigator.pushNamed(
                                    context,
                                    "/article",
                                    arguments: {"title":filelist[index]['name'],"content":filelist[index]['content']});
                              },
                              child: Text(filelist[index]['name']))
                        ],
                      ),
                    );
                  })
              )
          );},
      ),
    );
  }
}
