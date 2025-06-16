import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
class ai_item extends StatefulWidget {
  final name;
  final describe;
  final icon;
  final type;
  const ai_item({super.key,required this.name,required this.describe,required this.icon,required this.type});

  @override
  State<ai_item> createState() => _ai_itemState();
}

class _ai_itemState extends State<ai_item> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!['生成菜单','查热量','作业辅导','照片修复','姓氏壁纸','姓名打分','起名','手机号打分','提取文案','智能助手'].contains(widget.type)){
          showToast("请联系客服开启此功能，前往我的中心 > 客服 > 拨打电话",backgroundColor: Colors.black54,position: ToastPosition.bottom,radius: 40,textStyle: TextStyle(color: Colors.white));
        }
        else{
          Navigator.pushNamed(context, '/chat_view',arguments: {"title":widget.name,"type":widget.type});
        }
      },
      child: Column(
        children: [
          Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(15),
          child: Row(
            spacing: 20,
            children: [
              widget.icon,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5,),
                    Text(widget.describe,softWrap: true,style: TextStyle(color: Theme.of(context).shadowColor),)
                  ],
                ),
              )
            ],
          ),
        ),
          SizedBox(height: 10,)
        ]
      ),
    );
  }
}
