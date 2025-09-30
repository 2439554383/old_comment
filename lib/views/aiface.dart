import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:comment1/view_model/aiface_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vision_gallery_saver/vision_gallery_saver.dart';
class aiface extends StatefulWidget {
  const aiface({super.key});

  @override
  State<aiface> createState() => _aifaceState();
}

class _aifaceState extends State<aiface> {
  ImagePicker imagePicker = ImagePicker();
  Future? myfuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    late double fullwidth = MediaQuery.of(context).size.width;
    late double fullheight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) => aiface_viewmodel(),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("Ai换脸"),
        ),
        body: Center(
          child: Consumer<aiface_viewmodel>(
            builder: (BuildContext context, aiface_provider, Widget? child) {
              return Container(
                width: fullwidth*0.9,
                height: fullheight,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Flexible(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () async {
                          var image = await imagePicker.pickImage(source: ImageSource.gallery);
                          if(image!=null){
                            File imagefile = File(image.path);
                            aiface_provider.old_imagefile = imagefile;
                            aiface_provider.old_image = image.path;
                          }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CupertinoColors.secondarySystemBackground
                          ),
                          child: aiface_provider.old_imagefile!=null?Image.file(aiface_provider.old_imagefile):AutoSizeText("「点击上传模版图（如明星、角色）」"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Flexible(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () async {
                          var image = await imagePicker.pickImage(source: ImageSource.gallery);
                          if(image!=null){
                            File imagefile = File(image.path);
                            aiface_provider.face_imagefile = imagefile;
                            aiface_provider.face_image = image.path;
                          }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CupertinoColors.secondarySystemBackground
                          ),
                          child: aiface_provider.face_imagefile!=null?Image.file(aiface_provider.face_imagefile):AutoSizeText("「点击上传人脸图」"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Flexible(
                      flex: 3,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CupertinoColors.secondarySystemBackground
                          ),
                          child: FutureBuilder(
                              future: myfuture,
                              builder: (context,snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 10,),
                                      AutoSizeText("正在生成中～")
                                    ],
                                  );
                                }
                                else if(snapshot.hasData){
                                  return Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      GestureDetector(
                                        onTap: () async{
                                          final status = await Permission.photos.request();
                                          if(status.isGranted){
                                            final save_image = VisionGallerySaver.saveImage(
                                                aiface_provider.new_image
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
                                        child: Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(Icons.file_download),
                                              AutoSizeText("下载")
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Center(
                                        child: Stack(
                                          children: [
                                            Image.memory(aiface_provider.new_image),
                                            Positioned(
                                                bottom: 10.h,
                                                right: 10.w,
                                                child: Text("内容由Ai生成")
                                            )
                                          ],
                                        ),
                                      )),
                                    ],
                                  );
                                }
                                else if(snapshot.hasError){
                                  return AutoSizeText("合成失败");
                                }
                                else{
                                  return AutoSizeText("「生成结果将在这里显示」");
                                };
                              }
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text("内容由Ai生成")
                    ),
                    SizedBox(height: 20,),
                    Flexible(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                myfuture =  aiface_provider.post_aiface();
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.magic),
                                SizedBox(width: 5,),
                                AutoSizeText("换脸")
                              ],
                            ),)
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
