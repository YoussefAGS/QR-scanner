
import 'package:flutter/material.dart';

class ToolComponent extends StatelessWidget {
  const ToolComponent({Key? key, required this.toolIcon, required this.backgroundColor, required this.nameOfTool, required this.toolColor, required this.function}) : super(key: key);

  final IconData toolIcon;
  final Color toolColor;
  final VoidCallback function;
  final Color backgroundColor;
  final String nameOfTool;


  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        InkWell(
          onTap:function,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Icon(toolIcon,
            size: 30,
            color: Colors.white,),
          ),
        ),
        SizedBox(height: 8,),
        Text(nameOfTool,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),),
        SizedBox(height: 16,),
      ],
    );
  }
}
