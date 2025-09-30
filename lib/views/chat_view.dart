import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:comment1/view_model/chat_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';
class chat_view extends StatefulWidget {
  const chat_view({super.key});

  @override
  State<chat_view> createState() => _chat_viewState();
}

class _chat_viewState extends State<chat_view> {
  late var title = "";
  late var type = "";
  late var text0 = "";
  late chat_viewmodel chat_provider;
  late TextEditingController textEditingController = TextEditingController();
  late ScrollController scrollController = ScrollController();
  XFile? image ;
  File? file;
  String text ="";
  String hinttext ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chat_provider = Provider.of<chat_viewmodel>(context,listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    title = args['title'];
    type = args['type'];
    switch (type) {
      case "生成菜单":
        text0 = "你好，我可以根据食材帮你搭配菜谱，轻松搞定一日三餐～";
        hinttext = "输入您想要的菜品风格，如：健康、麻辣";
        break;

      case "查热量":
        text0 = "把食物告诉我，我来帮你快速查询热量，吃得健康又安心哦～";
        hinttext = "选择图片发送";
        break;

      case "姓名打分":
        text0 = "输入名字，我来为你解析名字寓意，看看它藏着哪些美好意义～";
        hinttext = "输入您的姓名";
        break;

      case "起名":
        text0 = "输入您的姓氏，我来为您生成寓意美好、朗朗上口的名字～";
        hinttext = "输入您的姓氏";
        break;
      default:
        text0 = "你好，我是你的AI助手，随时为你提供贴心又聪明的服务哦～";
        hinttext = "发消息";
    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    chat_provider.clear();
    chat_provider.streamcontroller.close();
  }
  @override
  Widget build(BuildContext context) {
    late double fullwidth = MediaQuery.sizeOf(context).width;;
    late double fullheight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title),
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyLarge!,
        child: Center(
          child: Consumer<chat_viewmodel>(
            builder: (BuildContext context, value, Widget? child) {
            return Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                      stream: chat_provider.streamcontroller.stream,
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(child: CircularProgressIndicator()),
                              SizedBox(height: 5,),
                              AutoSizeText("正在思考中…")
                            ],
                          ));
                        }
                        else if(snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData){
                            text  += snapshot.data;
                            WidgetsBinding.instance.addPostFrameCallback((v){
                              if(scrollController.hasClients){
                                scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent,
                                );
                              }
                            });

                        }
                        else if(snapshot.hasError){
                          text = "获取失败";
                        }
                      }
                      return chat_provider.isstart?Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Markdown(
                          controller: scrollController,
                          data: text,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            textScaler: TextScaler.linear(1.3)
                        ),),
                      ):Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 15,
                            children: [
                              ClipRRect(child: Image.asset("assets/images/appicon.png",width: 55,height: 55,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(25),),
                              Text(text0,style: TextStyle(fontSize: 23),),
                              type=="智能助手"?Text("我可以帮你答疑、写作、搜索、分析、快来跟我聊天吧",style: TextStyle(color: Colors.grey.shade600),):SizedBox.shrink()
                            ],
                          ),
                        ),
                        );
                    },
                  ),
                ),
                Container(
                  width: fullwidth*0.95,
                  child: Column(
                    children: [
                      ['生成菜单','查热量'].contains(type)?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              alignment: Alignment.centerLeft,
                              child: Text("内容由Ai生成")
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async{
                                image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if(image!=null){
                                  file = File(image!.path);
                                  chat_provider.hasimage = true;
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerRight,
                                child: chat_provider.hasimage?ClipRRect(borderRadius:BorderRadius.circular(10),child: Image.file(file!,width: 45,height: 45,fit: BoxFit.cover,)):Icon(Icons.add_photo_alternate,size: 50,color: Theme.of(context).primaryColor,),
                              ),
                            ),
                          )
                        ],
                      ):Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      alignment: Alignment.centerRight,
                      child: Text("内容由Ai生成")
                  ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: CupertinoColors.systemGrey5,
                                  blurRadius: 0.5,
                                  spreadRadius:1
                              )
                            ]
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true ,
                              hintText: hinttext,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: TextButton(style:ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor)),onPressed: (){
                                text = "";
                                chat_provider.isstart =true;
                                FocusScope.of(context).unfocus();
                                if(['姓名打分','起名','智能助手'].contains(type)){
                                  chat_provider.post_text(textEditingController.text, type);
                                  textEditingController.clear();
                                }
                                else if(['生成菜单','查热量'].contains(type)){
                                  if(image==null){
                                    showToast("请上传食物图",backgroundColor: Colors.black54,position: ToastPosition.top,radius: 40,textStyle: TextStyle(color: Colors.white));
                                  }
                                  else{
                                    chat_provider.post_image(textEditingController.text, image!.path, type);
                                    chat_provider.hasimage = false;
                                    textEditingController.clear();
                                  }
                                }

                              }, child: Text("发送"))
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ); },
          ),
        ),
      ),
    );
  }
}
