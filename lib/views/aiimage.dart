import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:comment1/view_model/aiimage_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'package:vision_gallery_saver/vision_gallery_saver.dart';
class aiimage extends StatefulWidget {
  const aiimage({super.key});

  @override
  State<aiimage> createState() => _aiimageState();
}

class _aiimageState extends State<aiimage> {
  Future? image_future;
  ImagePicker imagePicker = ImagePicker();
  late TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    late double fullwidth = MediaQuery.of(context).size.width;
    late double fullheight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) => aiimage_viewmodel(),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("Ai生图"),
        ),
        body: Center(
          child: Consumer<aiimage_viewmodel>(
            builder: (BuildContext context, aiimage_provider, Widget? child) {
              return Container(
                width: fullwidth*0.9,
                height: fullheight,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FutureBuilder(
                                    future: image_future,
                                    builder: (context,snapshot){
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 10,),
                                            AutoSizeText("正在生成图片～")
                                          ],
                                        );
                                      }
                                      else if(snapshot.hasData){
                                        print("hasdata");
                                        return Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            GestureDetector(
                                              onTap: () async{
                                                final status = await Permission.photos.request();
                                                if(status.isGranted){
                                                  final response = await http.get(Uri.parse(aiimage_provider.image));
                                                  print(response.bodyBytes);
                                                  final save_image = VisionGallerySaver.saveImage(
                                                      response.bodyBytes
                                                  );
                                                  save_image.whenComplete((){
                                                    showToast("保存成功",backgroundColor: Colors.black54,position: ToastPosition.bottom,radius: 40,textStyle: TextStyle(color: Colors.white));
                                                  });
                                                }
                                                else{
                                                  showToast("保存失败",backgroundColor: Colors.black54,position: ToastPosition.bottom,radius: 40,textStyle: TextStyle(color: Colors.white));
                                                  print("没有获取到权限");
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons.file_download),
                                                  AutoSizeText("下载")
                                                ],
                                              ),
                                            ),
                                            Expanded(child: Image.network(aiimage_provider.image)),
                                          ],
                                        );
                                      }
                                      else if(snapshot.hasError){
                                        return AutoSizeText("获取失败");
                                      }
                                      else{
                                        return AutoSizeText("「生成的图片将在这里显示」");
                                      }
                                      ;
                                    }
                                )
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
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
                            hintText: aiimage_provider.hinttext,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white,),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: TextButton(style:ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor)),onPressed: () async{
                               var post_text = textEditingController.text;
                               textEditingController.clear();
                               aiimage_provider.image = null;
                               FocusScope.of(context).unfocus();
                               image_future =  aiimage_provider.post_aiimage(post_text);
                            }, child: AutoSizeText("生成"))
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ); },
          ),
        ),
      ),
    );
  }
}
