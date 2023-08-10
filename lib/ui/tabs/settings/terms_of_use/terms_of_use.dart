import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../privacy_and_polices/body_of_item_of_Privacy and Polices.dart';
import '../privacy_and_polices/item_of_Privacy and Polices.dart';

class TermsOfUse extends StatefulWidget {
  static const String routeName = 'Terms Of Use';

  const TermsOfUse({Key? key}) : super(key: key);

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  int toolBody=-1;
  final List<String> PrivacyAndPolicesTirle = [
    "License and Usage",
    "User Obligations",
    "Privacy Policy",
  ];
  final List<String> PrivacyAndPolicesItemsBody = [
    "By installing and using our QR Code Scanner app, you are granted a non-exclusive, non-transferable license to use the app for personal purposes only.",
    "Users are required to use the QR Code Scanner app responsibly and refrain from engaging in any illegal activities, including but not limited to, scanning malicious or harmful QR codes.",
    "Our QR Code Scanner app respects your privacy. We collect only minimal user data, such as camera access for scanning QR codes. For more information, please review our Privacy Policy",
   ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(toolBody==-1){
          return true;
        }
        else{
          setState(() {});
          toolBody=-1;
          return false;
        }
      },
      child: toolBody==-1?Scaffold(
          appBar: AppBar(
            title: Text(
              'TermsOfUse'.tr(),
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
          body: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 16,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                toolBody=index;
                setState(() {

                });

              },
              child: PrivacyAndPolicesItem(title: PrivacyAndPolicesTirle[index].tr(),),
            ),
            itemCount: PrivacyAndPolicesTirle.length,
          )):BodyOfPrivacyAndPolicesItem(title:PrivacyAndPolicesTirle[toolBody].tr() ,body:PrivacyAndPolicesItemsBody[toolBody] ,),
    );
  }
}
