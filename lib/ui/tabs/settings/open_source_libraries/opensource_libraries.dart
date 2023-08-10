import 'package:flutter/material.dart';

class OpenSourceLibraries extends StatelessWidget {
  static const String routeName = 'Open Source Libraries';
  const OpenSourceLibraries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Source Libraries',style: TextStyle(
          color: Colors.black87,
          fontFamily: "Poppins",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,) ,
        ),
      ),
    body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
        children: [
          SizedBox(
              height: 20
          ),
          Container(
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
                  "AD Mob",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  )
              ),
            ),
          ),

          SizedBox(
              height: 20
          ),
          Container(
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
                  "Barcode Generation",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  )
              ),
            ),
          ),

          SizedBox(
              height: 20
          ),
          Container(
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
                  "Qr Code Scanner",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  )
              ),
            ),
          ),

          SizedBox(
              height: 20
          ),
          Container(
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
                  "Share",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  )
              ),
            ),
          ),

          SizedBox(
              height: 20
          ),
          Container(
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
                  "Screenshot",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
              ),
            ),
          ),

          SizedBox(
              height: 20
          ),
          Container(
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
                "Mobile Scanner",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(
              height: 20
          ),
          Container(
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
                "PDF",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

        ],
        ),
      ),
    ),
    );
  }
}
