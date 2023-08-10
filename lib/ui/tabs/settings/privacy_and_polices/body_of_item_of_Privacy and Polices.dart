import 'package:flutter/material.dart';

class BodyOfPrivacyAndPolicesItem extends StatelessWidget {
  const BodyOfPrivacyAndPolicesItem({Key? key, this.title, this.body})
      : super(key: key);
  final title, body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,) ,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 32,right: 16,left: 16,bottom: 32),
        margin: EdgeInsets.all(8),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            body,
            maxLines: 15,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
