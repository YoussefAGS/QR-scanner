
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingITem extends StatelessWidget {
  final VoidCallback oncleck;
  final String title;
  const SettingITem({Key? key, required this.oncleck, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:oncleck,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes the position of the shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
              title.tr(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              )
          ),
        ),

      ),
    );
  }
}
