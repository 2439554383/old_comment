import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/listview_viewmodel.dart';
class setting_type extends StatefulWidget {
  const setting_type({super.key});

  @override
  State<setting_type> createState() => _setting_typeState();
}

class _setting_typeState extends State<setting_type> {
  late listview_viewmodel listview_provider;
  String? code ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      listview_provider  = Provider.of<listview_viewmodel>(context,listen: false);
    get_list();
  }

  get_list()async{
    final sp = await SharedPreferences.getInstance();
    code = sp.getString("code");
    if(code!=null){
      listview_provider.get_list(code!);
      print(code);
    }
    else{print("未获得code");}
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("评论设置"),
      ),
      body: Center(
        child: Consumer<listview_viewmodel>(
          builder: (BuildContext context, listview_viewmodel value, Widget? child) {
          return listview_provider.isloadlist?Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                        children: [
                          ExpansionTile(
                              title: Text("评论类型"),
                              children:
                              List.generate(
                                listview_provider.type_list.length,
                                    (index) => CheckboxListTile(
                                      title: Text(listview_provider.type_list[index][1]), value: listview_provider.type_list[index][2], onChanged: (value) async{
                                          await listview_provider.switch_type_isset(value!, index);
                                    },
                                    ),
                              ),
                          ),
                        ],
                                      ),
                      ),
                    ),
                  ),
                Column(
                  children: [
                    Container(
                        width:MediaQuery.of(context).size.width*0.27,
                        height:MediaQuery.of(context).size.height*0.07,
                        child: FloatingActionButton(
                          onPressed: () async{
                            listview_provider.switch_comfirm(code);
                            Navigator.of(context).pop();
                          },
                          child: Text("确定",style: TextStyle(fontSize: 18),),)),
                    SizedBox(height: 40,)
                  ],
                ),
              ]
            ),
          ):CircularProgressIndicator();},
        ),
      ),
    );
  }
}
