
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/database_utils/barcode_utils.dart';
import 'package:qr_google_play/models/barcode_model.dart';
import 'package:qr_google_play/shared/components/alert_ok_dialog_component.dart';
import 'package:qr_google_play/ui/tabs/home_tab/tools/generate_qr_code_widget.dart';
import 'dart:ui' as ui;


class TextQrCodeGenerator extends StatefulWidget {
  bool isUrl=false;
  bool isPhone=false;
  String title='';

  TextQrCodeGenerator({required this.isUrl,required this.isPhone,required this.title});
  @override
  _TextQrCodeGeneratorState createState() => _TextQrCodeGeneratorState();
}

class _TextQrCodeGeneratorState extends State<TextQrCodeGenerator> {
  String qrData = ""; // The text for which you want to generate the QR code
  TextEditingController emailController = TextEditingController();
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
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(
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
            children: [
              showQr?GenerateQrCodeWidget(qrData:  qrData,)
                  :SizedBox(height: 0,),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: widget.isUrl==true?[
                  InkWell(
                    onTap: (){
                      setState(() {
                        qrData="https://"+qrData;
                        emailController = TextEditingController(text: qrData);

                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('https://',style: TextStyle(color: Colors.white,fontSize: 14),),),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        qrData+="www";
                        emailController = TextEditingController(text: qrData);

                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('www',style: TextStyle(color: Colors.white,fontSize: 14),),),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        qrData+=".com";
                        emailController = TextEditingController(text: qrData);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('.com',style: TextStyle(color: Colors.white,fontSize: 14),),),
                  ),

                ]:[],
              ),
              TextFormField(
                cursorColor: Colors.deepPurple.shade900,
                maxLength: 300,
                maxLines: 4,
                validator: (text){
                  if(text!.trim() == ''){
                    return "Please Enter Text".tr();
                  }

                  return null;
                },
                onChanged: (text){
                  qrData=text;
                  setState(() {

                  });
                },
                // textDirection: TextDirection.ltr,
                keyboardType: widget.isPhone==true? TextInputType.phone:TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple.shade900),
                  ),
                  prefixIcon: Icon(Icons.qr_code_scanner,color: Colors.black,size: 32,),
                  suffixIcon: IconButton(onPressed: (){
                    showRewardedAd();
                    Clipboard.setData(ClipboardData(text: qrData));
                  },icon: Icon(Icons.copy,color: Colors.deepPurple.shade900,size: 28,),),

                  hintText: 'Enter Text',
                  labelText: 'Enter text',
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

              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
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
                  validate();
                },
                child: Center(
                  child: Text(
                    'Generate QR Code',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.2),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> validate() async {
    await FirebaseFirestore.instance.disableNetwork();
    if(qrData.isEmpty){
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
          barcodeType: widget.title,
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
