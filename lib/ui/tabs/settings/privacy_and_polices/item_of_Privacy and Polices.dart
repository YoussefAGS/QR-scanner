import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyAndPolicesItem extends StatelessWidget {
  const PrivacyAndPolicesItem({Key? key, this.title})
      : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(5),
      height: 50,
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
      width: double.infinity,
      child: Center(
        child: Text(
            title,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

        ),
      ),
    );
  }
}

// Scaffold(
// appBar: AppBar(
// title: Text(
// '$title',
// style: TextStyle(
// color: Colors.black87,
// fontFamily: "Poppins",
// fontSize: 25,
// fontWeight: FontWeight.w600,
// ),
// ),
// elevation: 0.0,
// backgroundColor: Colors.transparent,
// ),
// body: Text("""
//       $bodyOfItem
//       """,
// ),
// );