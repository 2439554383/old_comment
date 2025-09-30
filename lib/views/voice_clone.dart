import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vision_gallery_saver/vision_gallery_saver.dart';

import '../view_model/voice_clone_viewmodel.dart';
class voice_clone extends StatefulWidget {
  const voice_clone({super.key});

  @override
  State<voice_clone> createState() => _voice_cloneState();
}

class _voice_cloneState extends State<voice_clone> {
  late TextEditingController textEditingController = TextEditingController();
  late AudioPlayer audioPlayer;
  ImagePicker imagePicker = ImagePicker();
  Future? my_future;

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
      create: (BuildContext context) => voice_clone_viewmodel(),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("声音克隆"),
        ),
        body: Center(
          child: Consumer<voice_clone_viewmodel>(
            builder: (BuildContext context, voice_clone_provider, Widget? child) {
              return Container(
                width: fullwidth*0.9,
                height: fullheight,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          voice_clone_provider.pick_audio();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CupertinoColors.secondarySystemBackground
                          ),
                          child: voice_clone_provider.post_voice!=null?Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.check_mark_circled_solid,color: Colors.green,),
                              SizedBox(width: 5.w,),
                              AutoSizeText("已上传语音样本",style: TextStyle(color: Colors.green),)
                            ],
                          ):AutoSizeText("「点击上传你的语音样本」")
                        //   Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       voice_clone_provider.post_voice!=null?GestureDetector(
                        //               onTap: (){
                        //                 if(voice_clone_provider.post_voice!=null){
                        //                   if(voice_clone_provider.player.playerState.processingState == ProcessingState.completed){
                        //                     print(2222);
                        //                     voice_clone_provider.player.seek(Duration.zero);
                        //                     voice_clone_provider.player.play();
                        //                   }
                        //                   else if(voice_clone_provider.player.playerState.playing){
                        //                     print(1111);
                        //                     voice_clone_provider.player.pause();
                        //                   }
                        //                   else{
                        //                     print(3333);
                        //                     voice_clone_provider.player.play();
                        //                   }
                        //                 }
                        //               },
                        //               child:Icon(CupertinoIcons.play_circle_fill,size:40,color: Theme.of(context).primaryColor)):SizedBox.shrink(),
                        //         voice_clone_provider.post_voice!=null?SizedBox(height: 10.h,):SizedBox.shrink(),
                        //         voice_clone_provider.post_voice!=null?Container(
                        //           height: 50.h,
                        //           child: StreamBuilder(
                        //               stream: voice_clone_provider.player.positionStream,
                        //               builder: (context, snapshot) {
                        //                   if(snapshot.hasData){
                        //                     return ProgressBar(
                        //                       timeLabelLocation: TimeLabelLocation.sides,
                        //                       progress: Duration(milliseconds: voice_clone_provider.player.position.inMilliseconds),
                        //                       total: Duration(milliseconds: voice_clone_provider.player.duration!.inMilliseconds,),
                        //                       buffered: Duration(milliseconds: 100),
                        //                       onSeek: (duration) {
                        //                         voice_clone_provider.player.seek(duration);
                        //                       },
                        //                     );
                        //                   }
                        //                   else{
                        //                     return SizedBox.shrink();
                        //                   }
                        //               }
                        //             ),
                        //         ):SizedBox.shrink(),
                        //       voice_clone_provider.post_voice!=null?SizedBox(height: 10,):SizedBox.shrink(),
                        //       voice_clone_provider.post_voice!=null?AutoSizeText("点击按钮播放音频"):AutoSizeText("「点击上传你的语音样本」"),
                        //     ]
                        // ),
                      ),
                    ),),
                    SizedBox(height: 20,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {

                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CupertinoColors.secondarySystemBackground
                          ),
                          child: FutureBuilder(
                              future: my_future,
                              builder: (context,snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 10,),
                                      AutoSizeText("正在合成音频～")
                                    ],
                                  );
                                }
                                else if(snapshot.hasData){
                                  print("hasdata");
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10,),
                                      GestureDetector(
                                        onTap: () async{
                                          final response = await http.get(Uri.parse(voice_clone_provider.get_voice));
                                          final temporary = await getTemporaryDirectory();
                                          final temporary_path = "${temporary.path}/temp_audio.wav";
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
                                        child: Container(
                                          padding: EdgeInsets.only(right: 10.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(Icons.file_download),
                                              AutoSizeText("下载")
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                  onTap: (){
                                                    if(voice_clone_provider.get_voice!=null){
                                                      if(voice_clone_provider.player1.playerState.processingState == ProcessingState.completed){
                                                        print(2222);
                                                        voice_clone_provider.player1.seek(Duration.zero);
                                                        voice_clone_provider.player1.play();
                                                      }
                                                      else if(voice_clone_provider.player1.playerState.playing){
                                                        print(1111);
                                                        voice_clone_provider.player1.pause();
                                                      }
                                                      else{
                                                        print(3333);
                                                        voice_clone_provider.player1.play();
                                                      }
                                                    }
                                                  },
                                                  child: voice_clone_provider.get_voice!=null?Icon(CupertinoIcons.play_circle_fill,size:40,color: Theme.of(context).primaryColor):SizedBox.shrink()),
                                              SizedBox(height: 10,),
                                              Container(
                                                height: 50.h,
                                                child: StreamBuilder(
                                                    stream: voice_clone_provider.player1.positionStream,
                                                    builder: (context, snapshot) {
                                                      return ProgressBar(
                                                        timeLabelLocation: TimeLabelLocation.sides,
                                                        progress: Duration(milliseconds: voice_clone_provider.player1.position.inMilliseconds),
                                                        total: Duration(milliseconds: voice_clone_provider.player1.duration!.inMilliseconds,),
                                                        buffered: Duration(milliseconds: 100),
                                                        onSeek: (duration) {
                                                          voice_clone_provider.player1.seek(duration);
                                                        },
                                                      );
                                                    }
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              AutoSizeText("点击按钮播放音频")
                                            ],
                                          ),
                                        ),
                                      )

                                    ],
                                  );
                                }
                                else if(snapshot.hasError){
                                  return AutoSizeText("获取失败");
                                }
                                else{
                                  return AutoSizeText("「语音生成后将在这里播放」");
                                };
                              }
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text("内容由Ai生成")
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
                            hintText: "输入你想克隆的话",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white,),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: TextButton(style:ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor)),onPressed: () async{
                                  my_future = voice_clone_provider.post_audio(textEditingController.text);
                                  textEditingController.clear();
                                  FocusScope.of(context).unfocus();
                            }, child: AutoSizeText("合成音频"))
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
