import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_google_play/ui/tabs/settings/privacy_and_polices/body_of_item_of_Privacy%20and%20Polices.dart';
import 'package:qr_google_play/ui/tabs/settings/privacy_and_polices/item_of_Privacy%20and%20Polices.dart';

class PrivacyAndPolices extends StatefulWidget {
  PrivacyAndPolices({Key? key}) : super(key: key);
  static const String routName = "ffff";

  @override
  State<PrivacyAndPolices> createState() => _PrivacyAndPolicesState();
}

class _PrivacyAndPolicesState extends State<PrivacyAndPolices> {
  int toolBody=-1;
  final List<String> PrivacyAndPolicesTirle = [
    "Introduction and Overview",
    "Information Collection and Use",
    "Data Sharing",
    "Security Measures",
    "User Rights and Choices",
    "Cookies and Tracking Technologies",
    "Children's Privacy",
    "Updates to Privacy Policy",
    "Legal Compliance",
  ];
  final List<String> PrivacyAndPolicesItemsBody = [
   "Our QR Code app is designed to help users generate and scan QR codes for various purposes. This privacy policy outlines how we collect, use, and protect your data when you interact with our app. By using our app, you agree to the practices described in this policy.",
    "When you use our QR Code app, we may collect certain information from your device, such as the type of device you're using, operating system version, and unique device identifiers. Additionally, the app may require access to your camera to scan QR codes and process image data. The information collected is used to provide the QR code functionality and improve the app's performance.",
    "We do not share your personal information with third parties for marketing purposes. However, we may share non-personal and aggregated information with analytics providers and business partners to gain insights into app usage and trends. Rest assured, your data privacy is a top priority for us.",
    "We take the security of your data seriously and implement various measures to protect it. This includes encryption of data transmissions, regular security audits, and access controls to limit unauthorized access to user data. In the event of a data breach, we will take immediate action to mitigate the impact and notify affected users as required by law.",
    "As a user, you have the right to access, correct, or delete the personal information we hold about you. If you wish to exercise any of these rights, please contact us through the provided contact information below. You also have the option to disable certain permissions within the app to limit data collection.",
    "Our app does not use cookies or tracking technologies to collect user data. However, some third-party services integrated with the app may have their own tracking practices. We encourage you to review the privacy policies of these third-party services for more information.",
    "Our QR Code app is not intended for children under the age of 13. We do not knowingly collect personal information from children. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us, and we will promptly delete the information.",
    "We may update this privacy policy from time to time to reflect changes in our practices or for legal reasons. Any modifications will be effective immediately upon posting the updated policy within the app. We recommend reviewing this policy regularly to stay informed about how we handle your data.",
    "Our app complies with applicable data protection laws and regulations, including but not limited to the General Data Protection Regulation (GDPR) and the California Consumer Privacy Act (CCPA)."
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
              'Privacy and Polices'.tr(),
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
