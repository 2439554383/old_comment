import 'dart:developer';
import 'dart:io';
import 'package:comment1/api/http_api.dart';
import 'package:comment1/view_model/listview_viewmodel.dart';
import 'package:comment1/view_model/mainpage_viewmodel.dart';
import 'package:comment1/view_model/overlay_viewmodel.dart';
import 'package:comment1/views/store_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'hospital_view.dart';
import 'home_view.dart';
import 'mine_view.dart';
import 'news_view.dart';
class main_view extends StatefulWidget {
  const main_view({super.key});

  @override
  State<main_view> createState() => _main_viewState();
}

class _main_viewState extends State<main_view> {
  int current_index = 0;
  late mainpage_viewmodel mainpage_provider ;
  var widget_list = [
    home_view(),
    hospital_view(),
    store_view(),
    news_view(),
    mine_view(),
  ];
  bool isLooking = false;

  @override
  void initState() {
    super.initState();
    mainpage_provider = Provider.of<mainpage_viewmodel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDiolog();
    });
  }

  showDiolog() async {
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState)=>
        Center(
          child: Material(
            child: Container(
              width: 300.w,
              height: 400.h,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("隐私政策",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600,color:Colors.black)),
                  SizedBox(height: 15.h,),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 9.w,vertical: 0),
                        child: ListView(
                            children: [
                              Text(
                                "本应用非常重视用户隐私政策并严格遵守相关的法律规定。请您仔细阅读《隐私政策》后再继续使用。如果您继续使用我们的服务，表示您已经充分阅读和理解我们协议的全部内容。",
                                style: TextStyle(fontSize: 14, height: 1.6),
                              ),
                              SizedBox(height: 15),

                              Text(
                                "本app尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更优质的服务，本应用会按照本隐私权政策的规定使用和披露您的个人信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，本应用不会将这些信息对外披露或向第三方提供。本应用会不时更新本隐私权政策。您在同意本应用服务使用协议之时，即视为您已经同意本隐私权政策全部内容。",
                                style: TextStyle(fontSize: 14, height: 1.6),
                              ),
                              SizedBox(height: 20),

                              Text(
                                "1. 适用范围",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("(a) 在您注册本应用app帐号时，您根据app要求提供的个人注册信息；", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(b) 在您使用本应用网络服务，或访问本应用平台网页时，本应用自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(c) 本应用通过合法途径从商业伙伴处取得的用户个人数据。", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(d) 本应用严禁用户发布不良信息，如裸露、色情和亵渎内容，发布的内容我们会进行审核，一经发现不良信息，会禁用该用户的所有权限，予以封号处理。", style: TextStyle(fontSize: 14, height: 1.6)),
                              SizedBox(height: 20),

                              Text(
                                "2. 信息使用",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("(a) 本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人登录信息。如果我们存储发生维修或升级，我们会事先发出推送消息来通知您，请您提前允许本应用消息通知。", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(b) 本应用亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何本应用平台用户如从事上述活动，一经发现，本应用有权立即终止与该用户的服务协议。", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(c) 为服务用户的目的，本应用可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与本应用合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。", style: TextStyle(fontSize: 14, height: 1.6)),
                              SizedBox(height: 20),

                              Text(
                                "3. 信息披露",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("(a) 未经您事先同意，我们不会向第三方披露；", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(b) 为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(c) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(d) 如您出现违反中国有关法律、法规或者本应用服务协议或相关规则的情况，需要向第三方披露；", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(e) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；", style: TextStyle(fontSize: 14, height: 1.6)),
                              SizedBox(height: 20),

                              Text(
                                "4. 信息存储和交换",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("本应用不收集的有关您的信息和资料。", style: TextStyle(fontSize: 14, height: 1.6)),
                              SizedBox(height: 20),

                              Text(
                                "5. Cookie的使用",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("(a) 在您未拒绝接受cookies的情况下，本应用会在您的计算机上设定或取用cookies，以便您能登录或使用依赖于cookies的本应用平台服务或功能。本应用使用cookies可为您提供更加周到的个性化服务，包括推广服务。", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(b) 您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的本应用网络服务或功能。", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(c) 通过本应用所设cookies所取得的有关信息，将适用本政策。", style: TextStyle(fontSize: 14, height: 1.6)),
                              SizedBox(height: 20),

                              Text(
                                "6. 本隐私政策的更改",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("(a) 如果决定更改隐私政策，我们会在本政策中、本公司网站中以及我们认为适当的位置发布这些更改，以便您了解我们如何收集、使用您的个人信息，哪些人可以访问这些信息，以及在什么情况下我们会透露这些信息。", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("(b) 本公司（上海一棵树网络科技有限公司成立于2018年12月26日，注册地位于上海市嘉定区华江路129弄7号JT7483室 电话：15618268878 邮箱地址：13356797958@163.com 保留随时修改本政策的权利，因此请经常查看。如对本政策作出重大更改，本公司会通过网站通知的形式告知。", style: TextStyle(fontSize: 14, height: 1.6)),
                              Text("方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是本应用用户名及密码发生泄露，请您立即联络本应用客服，以便本应用采取相应措施。", style: TextStyle(fontSize: 14, height: 1.6)),
                              SizedBox(height: 20),
                              Text(
                                "感谢您花时间了解我们的隐私政策！我们将尽全力保护您的个人信息和合法权益，再次感谢您的信任！",
                                style: TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w500),
                              ),
                            ]
                        )),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isLooking = !isLooking;
                      });
                    },
                    child: Row(
                      children: [
                        AbsorbPointer(
                          child: Checkbox(
                              value: isLooking,
                              onChanged: (value){

                          }),
                        ),
                        Text("我已阅读隐私政策的内容")
                      ],
                    ),
                  ),
                  Container(
                    width: 250.w,
                    child: TextButton(
                        onPressed:(){
                          if(isLooking){
                            Navigator.pop(context);
                          }
                          else{
                            showToast("请勾选我已阅读并确认");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(ColorScheme.of(context).primary)
                        ),
                        child: Text("下一步")
                    ),
                  ),
                  SizedBox(height: 15.h,),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<mainpage_viewmodel>(
      builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "主页"),
              BottomNavigationBarItem(icon: Icon(Icons.golf_course),label: "教程"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: "商品"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.news),label: "新闻"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),label: "我的"),
            ],
            currentIndex: mainpage_provider.current_index,
            onTap: (index){
                setState(() {
                  mainpage_provider.current_index = index;
                });
            },
          ),
          backgroundColor: CupertinoColors.tertiarySystemGroupedBackground,
        body: IndexedStack(index:mainpage_provider.current_index,children: widget_list)
      );
      },
    );
  }
}
