import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/database_utils/barcode_utils.dart';
import 'package:qr_google_play/models/barcode_model.dart';
import 'package:qr_google_play/shared/components/alert_ok_dialog_component.dart';


import 'generate_qr_code_widget.dart';
class EmailQRTool extends StatefulWidget {

  final String title ;

  EmailQRTool(this.title);

  @override
  _EmailQRToolState createState() => _EmailQRToolState();
}

class _EmailQRToolState extends State<EmailQRTool> {
  String qrData = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController SubgectController = TextEditingController();
  TextEditingController MessageControoler = TextEditingController();
  bool showQr = false;
  DateTime selectedTime = DateTime.now();



  RewardedAd? _rewardedAd;
  int _rewardScore =0;

  void _createRewardedAd(){
    RewardedAd.load(
      adUnitId: AdManager.rewardedAdUnitId!,
      request:  const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad)=>setState(()=> _rewardedAd = ad),
        onAdFailedToLoad: (error)=> setState(()=> _rewardedAd = null),
      ),
    );
  }
  void showRewardedAd(){
    if(_rewardedAd != null){
      _rewardedAd!.fullScreenContentCallback=FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad){
            ad.dispose();
            _createRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (ad,error){
            ad.dispose();
            _createRewardedAd();

          }
      );
      _rewardedAd!.show(
        onUserEarnedReward: (ad,reward)=>setState(() => _rewardScore++),
      );
      _rewardedAd = null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createRewardedAd();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('E-mail'.tr(),
        style: TextStyle(
          color: Colors.black87,
          fontFamily: "Poppins",
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child:
                showQr?
                GenerateQrCodeWidget(qrData:qrData)
                    :SizedBox(height: 0,),
              ),
              // Three text fields for entering data
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              TextFormField(
                cursorColor: Colors.deepPurple.shade900,

                validator: (text){
                  if(text!.trim() == ''){
                    return "Please Enter Email".tr();
                  }
                  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if(!emailValid){
                    return "Please Enter Correct Email".tr();
                  }
                  return null;
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email,color: Colors.deepPurple.shade900,),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple.shade900),
                  ),

                  hintText: 'Please Enter E-mail',
                  labelText: 'E-mail',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(121, 121, 121, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(121, 121, 121, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  focusColor: Colors.deepPurple.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),


              TextFormField(
                cursorColor: Colors.deepPurple.shade900,

                validator: (text){
                  if(text!.trim() == ''){
                    return "Please Enter subject".tr();
                  }
                  return null;
                },
                controller: SubgectController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.subject_outlined,color: Colors.deepPurple.shade900,),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple.shade900),
                  ),

                  hintText: 'Please Enter Subject',
                  labelText: 'Subject',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(121, 121, 121, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(121, 121, 121, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  focusColor: Colors.deepPurple.shade900,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 18,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.03,),


              TextFormField(
                maxLines: 4,
                validator: (text){
                  if(text!.trim() == ''){
                    return "enter at lest 10 word".tr();
                  }
                  return null;
                },
                controller: MessageControoler,
                cursorColor: Colors.deepPurple.shade900,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.message_outlined,color: Colors.deepPurple.shade900,size: 28,),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple.shade900),
                  ),

                  hintText: 'Please Enter Message',
                  labelText: 'Message',
                  labelStyle: const TextStyle(
                      color: Color.fromRGBO(121, 121, 121, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(121, 121, 121, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  focusColor: Colors.deepPurple.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 18,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.only(
                            right:
                            MediaQuery.of(context)
                                .size
                                .width *
                                0.25,
                            left: MediaQuery.of(context)
                                .size
                                .width *
                                0.25,
                            top: 8,
                            bottom: 8)),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.deepPurple.shade900),
                    visualDensity: VisualDensity.comfortable),
                onPressed: () {
                  showRewardedAd();
                  String data = "E-mail : ${emailController.text}\nSubject : ${SubgectController.text}\nMessage : ${MessageControoler.text}";
                    qrData = data;
                    validate();
                },
                child: Text(
                  'Generate QR Code'.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.2,)
            ],
          ),
        ),
      ),
    );
  }
  Future<void> validate() async {
    await FirebaseFirestore.instance.disableNetwork();
    if(emailController.text.isEmpty && SubgectController.text.isEmpty && MessageControoler.text.isEmpty){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext){
            return AlertDialogOkComponent(
              alertTitle: 'Incorrect',
              alertContent: 'Please, Enter Barcode',
            );
          });
    }else{
      MyBarcode barcode = MyBarcode(
          id: '',
          barcodeType: 'Email',
          barcodeContent: qrData,
          barcodeDate: '${selectedTime.day}/${selectedTime.month}/${selectedTime.year}'
      );
      BarcodeDatabase.addBarcodeToFirebase(barcode);
      setState(() {
        showQr = true;
      });
    }
  }
}



