import 'dart:io';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:comment1/view_model/chat_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
        break;

      case "查热量":
        text0 = "把食物告诉我，我来帮你快速查询热量，吃得健康又安心哦～";
        break;

      case "姓名打分":
        text0 = "输入名字，我来为你解析名字寓意，看看它藏着哪些美好意义～";
        break;

      case "起名":
        text0 = "告诉我你的喜好，我来帮你起个好听、有寓意的名字～";
        break;

      case "手机号打分":
        text0 = "输入手机号，我来为你测一测其中隐藏的吉凶和运势～";
        break;

      case "作业辅导":
        text0 = "遇到不会的题？发给我，我来帮你分析解答，轻松学习不费力～";
        break;

      case "照片修复":
        text0 = "发我一张老照片，我可以帮你修复模糊和划痕，还原清晰记忆～";
        break;

      case "姓氏壁纸":
        text0 = "告诉我你的姓氏，我来帮你生成专属的个性壁纸，美观又有意义～";
        break;

      case "提取文案":
        text0 = "把图片或视频内容发给我，我来帮你提取出文案，一目了然～";
        break;

      default:
        text0 = "你好，我是你的AI助手，随时为你提供贴心又聪明的服务哦～";
    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    chat_provider.isstart =false;
    chat_provider.hasimage = false ;
    chat_provider.res_text = "";
    chat_provider.streamcontroller.close();
  }
  @override
  Widget build(BuildContext context) {
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
                          return Center(child: CircularProgressIndicator(),);
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
                              ClipRRect(child: Image.asset("assets/images/appicon.jpg",width: 55,height: 55,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(25),),
                              Text(text0,style: TextStyle(fontSize: 23),),
                              type=="智能助手"?Text("我可以帮你答疑、写作、搜索、分析、快来跟我聊天吧",style: TextStyle(color: Colors.grey.shade600),):SizedBox.shrink()
                            ],
                          ),
                        ),
                        );
                    },
                  ),
                ),
                ['生成菜单','查热量','作业辅导','照片修复','姓氏壁纸'].contains(type)?GestureDetector(
                  onTap: () async{
                    image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if(image!=null){
                      file = File(image!.path);
                      chat_provider.hasimage = true;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 5,bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    child: chat_provider.hasimage?ClipRRect(borderRadius:BorderRadius.circular(10),child: Image.file(file!,width: 45,height: 45,fit: BoxFit.cover,)):Icon(Icons.add_photo_alternate,size: 50,color: Theme.of(context).primaryColor,),
                  ),
                ):SizedBox.shrink(),
                Container(
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
                      hintText: "发消息",
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
                        if(['姓名打分','起名','手机号打分','提取文案','智能助手'].contains(type)){
                          chat_provider.post_text(textEditingController.text, type);
                        }
                        else if(['生成菜单','查热量','作业辅导','照片修复','姓氏壁纸'].contains(type)){
                          chat_provider.post_image(textEditingController.text, image!.path, type);
                          chat_provider.hasimage = false;
                        }
                        textEditingController.clear();
                      }, child: Text("发送"))
                    ),
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
