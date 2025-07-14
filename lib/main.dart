import 'package:comment1/view_model/overlay_viewmodel.dart';
import 'package:comment1/views/MiniInputView.dart';
import 'package:comment1/views/aiface.dart';
import 'package:comment1/views/aiimage.dart';
import 'package:comment1/views/article.dart';
import 'package:comment1/views/buildAppWithProviders.dart';
import 'package:comment1/views/chat_view.dart';
import 'package:comment1/views/file_view.dart';
import 'package:comment1/views/filetype_view.dart';
import 'package:comment1/views/main_view.dart';
import 'package:comment1/views/open_member.dart';
import 'package:comment1/views/overlay_view.dart';
import 'package:comment1/views/setting_type.dart';
import 'package:comment1/views/support_view.dart';
import 'package:comment1/views/voice_clone.dart';
import 'package:comment1/views/watermark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
main() {
  WidgetsFlutterBinding.ensureInitialized();
    runApp(
      buildAppWithProviders(
        OKToast(
          child: ScreenUtilInit(
            designSize: Size(411, 915),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
              theme: ThemeData.light().copyWith(
                  scaffoldBackgroundColor:Colors.white,
                  appBarTheme: AppBarTheme(
                    backgroundColor: Color.fromARGB(255, 248, 248, 248),
                  ),
                  textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          backgroundColor: WidgetStatePropertyAll(Colors.deepOrange),
                          textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white))
                      )
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.deepOrange),
                          foregroundColor: WidgetStatePropertyAll(Colors.white)
                      )
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: Colors.transparent,
                      unselectedItemColor: Colors.grey,
                      selectedItemColor: Colors.orange,
                      unselectedLabelStyle: TextStyle(color: Colors.black),
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      elevation: 0
                  )
              ),
                routes: {
                  "/main_view": (context)=> main_view(),
                  "/setting_type":(context)=>setting_type(),
                  "/file_view":(context)=>file_view(),
                  "/support_view":(context)=>support_view(),
                  "/article":(context)=>article(),
                  "/chat_view":(context)=>chat_view(),
                  "/filetype_view":(context)=>filetype_view(),
                  "/aiface":(context)=>aiface(),
                  "/aiimage":(context)=>aiimage(),
                  "/watermark":(context)=>watermark(),
                  "/voice_clone":(context)=>voice_clone(),
                  "/open_member":(context)=>open_member(),

                },
                title: "comment",
                home: main_view(),
              ),
          ),
        ),
      ));

}

@pragma("vm:entry-point")
void overlayMain() async{
  runApp(
    buildAppWithProviders(
      OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor:    CupertinoColors.tertiarySystemGroupedBackground,
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        backgroundColor: WidgetStatePropertyAll(ThemeData.light().primaryColor),
                        textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white))
                    )
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.deepOrange),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.transparent,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Colors.orange,
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0
                )
            ),
          home: overlay_view()
        ),
      ),
    ),
  );
}