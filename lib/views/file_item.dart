import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
class file_item extends StatefulWidget {
  final name;
  final describe;
  final icon;
  final type;
  const file_item({super.key,required this.name,required this.describe,required this.icon,required this.type});

  @override
  State<file_item> createState() => _file_itemState();
}

class _file_itemState extends State<file_item> {
  late double fullwidth = MediaQuery.of(context).size.width;
  late double fullheight = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/filetype_view',arguments: {
          "type":widget.type
        });
      },
      child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              ),
              width: fullwidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    height: fullheight*0.1,
                    child: Row(
                      children: [
                        Text(widget.name,style: TextStyle(fontSize: 20),),
                        widget.icon,
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(padding: EdgeInsets.only(left: 15),child: Text(widget.describe,softWrap: true,style: TextStyle(color: Theme.of(context).shadowColor),)),
                ],
              ),
            ),
    );
  }
}
