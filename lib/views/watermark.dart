import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:comment1/view_model/watermark_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:vision_gallery_saver/vision_gallery_saver.dart';
class watermark extends StatefulWidget {
  const watermark({super.key});

  @override
  State<watermark> createState() => _watermarkState();
}

class _watermarkState extends State<watermark> {
  late TextEditingController textEditingController = TextEditingController();
  late ImagePicker imagePicker = ImagePicker();
  late VideoPlayerController videoPlayerController;
  Future? my_future;
  var isinit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    if(isinit == true){
      videoPlayerController.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    late double fullwidth = MediaQuery.of(context).size.width;
    late double fullheight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context)=> watermark_viewmodel(),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("一键去水印"),
        ),
        body: Center(
          child: Container(
            width: fullwidth*0.9,
            height: fullheight,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Consumer<watermark_viewmodel>(
                  builder: (BuildContext context, watermark_provider, Widget? child) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () async {
                              if(videoPlayerController.value.isPlaying){
                                videoPlayerController.pause();
                              }
                              else{
                                videoPlayerController.play();
                              }
                              },
                        child:
                          Container(
                            alignment: Alignment.center,
                            child: FutureBuilder(
                                future: my_future,
                                builder: (context,snapshot){
                                  if(snapshot.connectionState ==ConnectionState.waiting){
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10,),
                                        AutoSizeText("努力去水印中，请稍候～")
                                      ],
                                    );
                                  }
                                  else if(snapshot.hasData) {
                                    if(videoPlayerController.value.isInitialized){
                                      return Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          GestureDetector(
                                            onTap: () async{
                                              final response = await http.get(Uri.parse(watermark_provider.download_video));
                                              final temporary = await getTemporaryDirectory();
                                              final temporary_path = "${temporary.path}/temp_video.mp4";
                                              File file = File(temporary_path);
                                              await file.writeAsBytes(response.bodyBytes);
                                              final status = await Permission.videos.request();
                                              if(status.isGranted){
                                                final save_video  = VisionGallerySaver.saveFile(temporary_path);
                                                save_video.whenComplete(() async{
                                                  showToast("保存成功",backgroundColor: Colors.black54,position: ToastPosition.bottom,radius: 40,textStyle: TextStyle(color: Colors.white));
                                                  await file.delete();
                                                });
                                              }
                                              else{
                                                print("保存失败");
                                                showToast("保存失败",backgroundColor: Colors.black54,position: ToastPosition.bottom,radius: 40,textStyle: TextStyle(color: Colors.white));
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
                                          Expanded(child: VideoPlayer(videoPlayerController)),
                                        ],
                                      );
                                    }
                                    else{
                                      return AutoSizeText("「处理后的视频将在这里展示」");
                                    }
                                  }
                                  else if(snapshot.hasError){
                                    return AutoSizeText("去水印失败");
                                  }
                                  else{
                                    print("else not hasdata");
                                    return AutoSizeText("「处理后的视频将在这里展示」");
                                  }
                                }
                            ),
                          ),

                    ),
                  );  },
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
                        hintText: "粘贴视频链接（抖音、快手等）",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white,),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        suffixIcon: Consumer<watermark_viewmodel>(
                          builder: (BuildContext context, watermark_provider, Widget? child) {
                          return TextButton(style:ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor)),onPressed: () async{
                              var text = textEditingController.text;
                              textEditingController.clear();
                              FocusScope.of(context).unfocus();
                              my_future = watermark_provider.remove_watermark(text).then((_) async {
                                if(watermark_provider.download_video!=null){
                                  videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(watermark_provider.download_video));
                                  await videoPlayerController.initialize();
                                  setState(() {
                                    isinit = true;
                                  });
                                }
                                return true;
                              });
                          }, child: AutoSizeText("去水印")); },
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
