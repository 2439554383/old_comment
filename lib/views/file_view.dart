import 'package:comment1/view_model/filelist_viewmodel.dart';
import 'package:comment1/views/startaccount_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file_item.dart';
class file_view extends StatefulWidget {
  const file_view({super.key});

  @override
  State<file_view> createState() => _file_viewState();
}

class _file_viewState extends State<file_view> with SingleTickerProviderStateMixin{
  late filelist_viewmodel filelist_provider;
  late TabController tabController = TabController(length: filelist_provider.text_list.length, vsync: this);
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
    late final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    print(args);
    filelist_provider.get_filelist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        title: Text("资料汇总"),
      ),
      body:Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                ...List.generate(filelist_provider.text_list.length, (index){
                  return file_item(name: filelist_provider.text_list[index], describe: filelist_provider.desc_list[index], icon: filelist_provider.icon_list[index], type: filelist_provider.type_list[index],);
                })
              ],
            ),
          ),
        ),
      )
    );
  }
}
