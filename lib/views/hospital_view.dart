import 'package:comment1/view_model/hospital_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
class hospital_view extends StatefulWidget {
  const hospital_view({super.key});

  @override
  State<hospital_view> createState() => _hospital_viewState();
}

class _hospital_viewState extends State<hospital_view> {
  late hospital_viewmodel _hospital_provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hospital_provider = Provider.of<hospital_viewmodel>(context,listen:false );
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _hospital_provider.get_list();
  }
  @override
  Widget build(BuildContext context) {
    double fullwidth = MediaQuery.of(context).size.width;
    double fullheight = MediaQuery.of(context).size.height;
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
            child: SafeArea(
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 20,color: Colors.black),
                child: Consumer<hospital_viewmodel>(
                  builder: (BuildContext context, value, Widget? child) {
                  return Container(
                    width: fullwidth*0.9,
                    height: fullheight,
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      spacing: 15,
                      children: List.generate(_hospital_provider.hospital_list.length, (index){
                        return Container(
                          height: fullheight*0.15,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_hospital_provider.text_list[index],style: TextStyle(fontSize: 20),),
                              SizedBox(width: 40,),
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    _hospital_provider.get_excel(_hospital_provider.hospital_list[index]['path'],_hospital_provider.hospital_list[index]['name']);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset("assets/images/excel.png",width: 35,height:35,fit:BoxFit.cover),
                                          SizedBox(width: 5,),
                                          Expanded(child: Text(_hospital_provider.hospital_list[index]['name'],overflow: TextOverflow.ellipsis,maxLines: 1,))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: 5,
                                        children: [
                                          Icon(Icons.upload_rounded,size: 25,color: Colors.grey,),
                                          Text("点击打开",style: TextStyle(fontSize: 15,color: Color.fromARGB(
                                              255, 90, 90, 90)),)
                                        ],
                                      )
                                    ],
                                  )
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ); },
                ),
              ),
            )),
      ),
    );
  }
}
