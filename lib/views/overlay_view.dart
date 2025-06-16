import 'dart:async';
import 'package:comment1/view_model/content_viewmodel.dart';
import 'package:comment1/view_model/overlay_viewmodel.dart';
import 'package:comment1/view_model/textfield_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:provider/provider.dart';
import '../view_model/listview_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class overlay_view extends StatefulWidget {
  const overlay_view({super.key});

  @override
  State<overlay_view> createState() => _overlay_viewState();
}
class _overlay_viewState extends State<overlay_view> with SingleTickerProviderStateMixin{
  Future<String>? future_comment;
  String text  = "";
  String content = "";
  var istrue = false;
  late overlay_viewmodel overlay_provider ;
  late listview_viewmodel listview_provider ;
  late textfield_viewmodel textfield_provider ;
  late content_viewmodel content_provider ;
  static const overlayChannel = MethodChannel('com.example.message1');
  late TextEditingController textEditingController = TextEditingController(text:textfield_provider.content);
  late TextEditingController textEditingController1 = TextEditingController();
  late TextEditingController textEditingController2 = TextEditingController();
  late TextEditingController textEditingController3 = TextEditingController();
  late double fullwidth = MediaQuery.of(context).size.width;
  late double fullheight = MediaQuery.of(context).size.height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    overlayChannel.setMethodCallHandler((call) async {
      if (call.method == "onSystemBack") {
        print("收到原生返回键通知");
        await FlutterOverlayWindow.closeOverlay();
      }
    });
    overlay_provider  = Provider.of<overlay_viewmodel>(context,listen: false);
    listview_provider  = Provider.of<listview_viewmodel>(context,listen: false);
    textfield_provider  = Provider.of<textfield_viewmodel>(context,listen: false);
    content_provider  = Provider.of<content_viewmodel>(context,listen: false);
    final listen1 = FlutterOverlayWindow.overlayListener.listen((event) async {
      print("Current_event:$event");
      if(event["type"] == "switch_window"){
        overlay_provider.switch_windows(true);
      }
      else if(event["type"] == "listview"){
        print("listview");
        listview_provider.type_overlay_list = event['type_overlay_list'];
        listview_provider.isloadlist = true;
      }
    });

  }
  post_comment(String ts1,String st2) {
    setState(() {
      listview_provider.comment_list.add(ts1);
      future_comment = textfield_provider.get_comment(textEditingController.text,listview_provider.comment_list,st2);
      listview_provider.comment_list.remove(ts1);
    });
  }
  close_windows()async{
    FlutterOverlayWindow.disposeOverlayListener();
    await FlutterOverlayWindow.closeOverlay();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    close_windows();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Consumer<overlay_viewmodel>(
        builder: (BuildContext context, value, Widget? child) {
            return overlay_provider.isvisiable?
            Center(
              child: GestureDetector(
                onTap: () async{
                    await FlutterOverlayWindow.closeOverlay();
                    overlay_provider.switch_windows(false);
                    await FlutterOverlayWindow.showOverlay(
                        width: WindowSize.matchParent,
                        height: 1200 ,
                        visibility: NotificationVisibility.visibilityPublic,
                        alignment :OverlayAlignment.topCenter,
                        flag: OverlayFlag.focusPointer,
                        startPosition: OverlayPosition(0,0)
                    );
                    },
                child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                              )
                            ]
                          ),
                          alignment: Alignment.center,
                          child: Text("生成",style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
              ),
            ) : Consumer<listview_viewmodel>(
              builder: (BuildContext context, value, Widget? child) {
               return Center(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey
                          )
                        ]
                    ),
                  child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Flexible(
                      flex: 7,
                      child: listview_provider.isloadlist?Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listview_provider.type_overlay_list.length,
                          itemBuilder: (conntext,index){
                            return Row(
                              children: [
                                Checkbox(value: listview_provider.type_overlay_list[index][3], onChanged: (value){
                                   listview_provider.switch_type_isset1(value!, index);
                                }),
                                Expanded(child: Container(child: Text(listview_provider.type_overlay_list[index][1],softWrap: true,)))
                              ],
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio:6/3)),
                      ):Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()),
                    ),
                    Flexible(
                      flex: 2,
                      child: TextField(
                        controller: textEditingController1,
                        decoration: InputDecoration(
                          contentPadding:EdgeInsets.symmetric(horizontal: 8, vertical: 4) ,
                          hintText: "自定义提示词",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic,),
                        ),
                      )
                    ),
                    Flexible(
                        flex: 2,
                        child: TextField(
                          controller: textEditingController2,
                          decoration: InputDecoration(
                              hintText: "字数",
                            hintStyle: TextStyle(fontStyle: FontStyle.italic),
                            contentPadding:EdgeInsets.symmetric(horizontal: 8, vertical: 4) ,
                          ),
                        )
                    ),
                    child!,
                    SizedBox(height: 5,),
                    Flexible(
                      flex: 2,
                      child: Row(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: TextButton(onPressed: () async{
                              FocusScope.of(context).unfocus();
                              post_comment(textEditingController1.text,textEditingController2.text);
                              // overlay_provider.switch_windows(true);
                              // await FlutterOverlayWindow.closeOverlay();
                              // await FlutterOverlayWindow.showOverlay(
                              //     width: 200,
                              //     height: 200,
                              //     enableDrag: true,
                              //     alignment :OverlayAlignment.topRight,
                              //     positionGravity: PositionGravity.auto,
                              //     startPosition: OverlayPosition(0,200)
                              // );
                            },
                                child: Text("获取"),
                              style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(106, 30))
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextButton(onPressed: (){
                              listview_provider.reset();
                            }, child: Text("重置"),style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(106, 30))
                            ),),
                          ),
                          Flexible(
                            child: TextButton(
                                style: ButtonStyle(
                                    fixedSize: WidgetStatePropertyAll(Size(106, 30))
                                ),
                                onPressed: ()async{
                              await content_provider.post_content("");
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return Center(
                                      child: Dialog(
                                        child: Material(
                                          borderRadius: BorderRadius.circular(20),
                                          type: MaterialType.card,
                                          elevation: 10,
                                          color: CupertinoColors.secondarySystemBackground,
                                          child: Container(
                                            height:300,
                                            width: fullwidth*0.65,
                                            child: Consumer<content_viewmodel>(
                                              builder: (BuildContext context, value, Widget? child) {
                                                return Column(
                                                  children: [
                                                    SizedBox(height: 5,),
                                                    Expanded(
                                                      child: Container(
                                                        width:fullwidth*0.65,
                                                        child: ListView.builder(
                                                            itemCount: content_provider.contentlist.length,
                                                            itemBuilder: (context,index){
                                                              return GestureDetector(
                                                                onTap: () async {
                                                                  content = content_provider.contentlist[index];
                                                                  try {
                            
                                                                    await overlayChannel.invokeMethod('printMessage', {'msg': content});
                                                                  } on PlatformException catch (e) {
                                                                    print("发送失败: ${e.message}");
                                                                  }
                                                                },
                                                                child: Container(
                                                                  margin: EdgeInsets.all(5),
                                                                  height: 30,
                                                                  alignment: Alignment.center,
                                                                  width: fullwidth,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    color: Colors.white,
                                                                  ),
                                                                  child: Text(content_provider.contentlist[index]),
                                                                ),
                            
                                                              );
                                                            }),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: fullwidth*0.6,
                                                      height:40,
                                                      child: TextField(
                                                        controller: textEditingController3,
                                                        decoration: InputDecoration(
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                                borderSide: BorderSide(color: CupertinoColors.secondarySystemBackground)
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                                borderSide: BorderSide(color: CupertinoColors.secondarySystemBackground)
                                                            ),
                                                            suffixIcon: TextButton(onPressed: (){
                                                              FocusScope.of(context).unfocus();
                                                              content_provider.post_content(textEditingController3.text);
                                                              textEditingController3.clear();
                                                              Navigator.pop(context);
                                                            }, child: Text("添加"))
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                  ],
                                                ); },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }, child: Text("常用语句")),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 3,),
                    Flexible(
                      flex: 2,
                      child: Row(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: TextButton(
                              style: ButtonStyle(
                                  fixedSize: WidgetStatePropertyAll(Size(75, 30))
                              ),
                              onPressed: () async {
                                content = textEditingController.text;
                                try {

                                  await overlayChannel.invokeMethod('printMessage', {'msg': content});
                                } on PlatformException catch (e) {
                                  print("发送失败: ${e.message}");
                                }
                              },
                              child: Text("复制"),
                            ),
                          ),
                          Flexible(
                            child: TextButton(
                                style: ButtonStyle(
                                    fixedSize: WidgetStatePropertyAll(Size(75, 30))
                                ),
                                onPressed: () async{
                              try {
                                final result = await overlayChannel.invokeMethod<String>('get_board');
                                print("原生剪贴板内容: $result");
                                textEditingController.text = result!;
                                // 你可以把它赋值到 TextEditingController 等地方
                              } on PlatformException catch (e) {
                                print("获取剪贴板失败: ${e.message}");
                              }
                            }, child: Text("粘贴")),
                          ),
                          Flexible(
                            child: TextButton(
                                style: ButtonStyle(
                                    fixedSize: WidgetStatePropertyAll(Size(75, 30))
                                ),
                                onPressed: () async{
                                  textEditingController.clear();
                                }, child: Text("清空")),
                          ),

                          Flexible(
                            child: TextButton(
                                style: ButtonStyle(
                                    fixedSize: WidgetStatePropertyAll(Size(75, 30))
                                ),
                                onPressed: () async{
                              await FlutterOverlayWindow.closeOverlay();
                              await FlutterOverlayWindow.showOverlay(
                                  width: 200,
                                  height: 200,
                                  enableDrag: true,
                                  alignment :OverlayAlignment.topRight,
                                  positionGravity: PositionGravity.auto,
                                  startPosition: OverlayPosition(0,200)
                              );
                              textEditingController.text = "请选择评论类型后点击获取";
                              overlay_provider.switch_windows(true);
                              listview_provider.reset();
                            }, child: Text("关闭")),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,)

                  ]
                                          ),
                ),
              ); },
              child: Flexible(
                flex: 4,
                child: Consumer<textfield_viewmodel>(
                  builder: (BuildContext context, value, Widget? child) {
                    textEditingController.text = textfield_provider.content;
                    return StreamBuilder(
                      stream: textfield_provider.streamcontroller.stream,
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(),);
                        }
                        else if(snapshot.connectionState == ConnectionState.active){
                           if (snapshot.hasError) {
                            textEditingController.text = "获取失败";
                          }
                           else if (snapshot.hasData) {
                            textEditingController.text += snapshot.data!;
                          }
                        }
                        return TextField(
                          controller: textEditingController,
                          maxLines: 10,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:EdgeInsets.symmetric(horizontal: 8, vertical: 4) ,
                            hintStyle: TextStyle(fontStyle: FontStyle.italic),
                            hintText: "https://v.douyin.com/2mOjGQQiqm0/"
                          ),
                        );
                      },
                    );},
                ),
              ),
            );
            },
          )
      ),
    );
  }
}
