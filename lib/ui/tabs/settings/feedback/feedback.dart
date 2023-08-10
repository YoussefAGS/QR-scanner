import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  static const String routeName = 'Feedback';

   FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
String feedbackTxt = ' ';

TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback',style: TextStyle(
          color: Colors.black87,
          fontFamily: "Poppins",
          fontSize: 21,
          fontWeight: FontWeight.w600,
        ),),
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
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.feedback,color: Colors.deepPurple.shade900,size: 80,),
            Center(child: Text('Pleas, Tell Us Your Problem',
              style: TextStyle(
              color: Colors.black87,
              fontFamily: "Poppins",
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),)),
            SizedBox(height: 32,),
            TextFormField(
              maxLines: 4,
              onChanged: (txt){
                feedbackTxt = txt;
              },
              // textDirection: TextDirection.ltr,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: feedbackController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurple.shade900),
                ),
                prefixIcon: Icon(Icons.message,color: Colors.deepPurple.shade900,size: 32,),
                hintText: 'Pleas, Tell Us more details about Your Problem',

                labelStyle: const TextStyle(
                    color: Color.fromRGBO(121, 121, 121, 1.0),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
                hintStyle: const TextStyle(
                    color: Color.fromRGBO(121, 121, 121, 1.0),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                focusColor: Colors.deepPurple.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: Colors.black87),
                ),
              ),
              style:  TextStyle(
                color: Colors.deepPurple.shade900,
                fontWeight: FontWeight.bold,
                wordSpacing: 1,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 32,),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.only(
                          right:
                          MediaQuery.of(context)
                              .size
                              .width *
                              0.3,
                          left: MediaQuery.of(context)
                              .size
                              .width *
                              0.3,
                          top: 16,
                          bottom: 16)),
                  backgroundColor: MaterialStatePropertyAll(
                      Colors.deepPurple.shade900),
                  visualDensity: VisualDensity.comfortable),
              onPressed: () {
               feedbackController.clear();
               feedbackTxt = '';
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                 backgroundColor: Colors.green.shade900,
                 content: Text(
                   "Feedback sent Successfuly.",
                   style: TextStyle(
                     fontSize: 16,
                       color: Colors.white,
                       fontFamily: "Poppins",
                       fontWeight: FontWeight.w600),
                 ),
               ));

               setState(() {

               });
              },
              child: Text(
                'Feedback',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
