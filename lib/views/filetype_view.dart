import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/filelist_viewmodel.dart';
class filetype_view extends StatefulWidget {
  const filetype_view({super.key});

  @override
  State<filetype_view> createState() => _filetype_viewState();
}

class _filetype_viewState extends State<filetype_view> {
  late filelist_viewmodel filelist_provider;
  late var type = "";
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
    final args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    type = args['type'];
  }
  @override
  Widget build(BuildContext context) {
    double fullwidth = MediaQuery.of(context).size.width;
    double fullheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:Consumer<filelist_viewmodel>(
        builder: (BuildContext context, value, Widget? child) {
          final filelist = filelist_provider.file_dict[type];
          if (filelist == null || filelist.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          else{
            return Center(
                child: Container(
                  width: fullwidth*0.92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      children:[
                        SizedBox(height: MediaQuery.of(context).padding.top+20,),
                        ...List.generate(filelist.length, (index){
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
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 10,top: 10),
                                        child: Text(filelist[index]['name'],style: TextStyle(fontSize: 20),)
                                    )),
                                Divider(color: CupertinoColors.systemGrey5,)
                              ],
                            ),
                          );
                        })]
                  ),
                )
            );
          }
        },
      ),
    );
  }
}
