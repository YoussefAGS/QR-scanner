
import 'package:flutter/material.dart';

class BarcodeComponent extends StatelessWidget {
  const BarcodeComponent({Key? key, required this.backgroundColor, required this.nameOfTool, required this.toolColor, required this.function}) : super(key: key);

  final Color toolColor;
  final VoidCallback function;
  final Color backgroundColor;
  final String nameOfTool;


  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        SizedBox(height: 16,),
        InkWell(
          onTap:function,
          child: Container(
            padding: EdgeInsets.only(top: 8,bottom: 8,right: 12,left: 12),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Image.asset(
              'assets/images/barcode.png',
              width: 42,
              height: 50,
              color: Colors.white,
            ),
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
