import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/shared/components/barcode_icon_component.dart';
import 'package:qr_google_play/ui/tabs/home_tab/barcode/generate_barcode_widget.dart';
import 'package:qr_google_play/ui/tabs/home_tab/tools/email_tool.dart';
import 'package:qr_google_play/ui/tabs/home_tab/tools/text.dart';
import '../../../shared/components/tool_icon_component.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int toolBody=-1;
  final List<Widget> screens = [
    /// toolBody= 0
    TextQrCodeGenerator(isUrl: false,isPhone: false,title: "Text".tr(),),

    /// toolBody= 1
    TextQrCodeGenerator(isUrl: false,isPhone: true,title: "Phone".tr(),),


    /// toolBody= 2
    EmailQRTool("ddd"),

    /// toolBody= 3
    TextQrCodeGenerator(isUrl: true,isPhone: false,title: "Link".tr(),),

    /// toolBody= 4
    TextQrCodeGenerator(isUrl: false,isPhone: true,title: "Phone".tr(),),

    /// toolBody= 5
    GenerateBarcodeWidget(
      isTelepen: false,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'EAN-8',
      instructions: 'Only 7 Digits & 1 Check Digit'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.ean8(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
     typeKeyboard: TextInputType.number,
      maxLengthInBarcode: 7,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 7,

    ),

    /// toolBody= 6
    GenerateBarcodeWidget(
      isTelepen: true,

      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'Telepen',
      instructions: 'Up to 50 Characters'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.telepen(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),],
    typeKeyboard: TextInputType.text,
      maxLengthInBarcode: 50,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 50,
    ),

    /// toolBody= 7
    GenerateBarcodeWidget(
      isTelepen: false,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: true,
      barcodeName: 'ISBN',
      instructions: 'Only 12 Digits & 1 Check Digit'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.isbn(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
    typeKeyboard: TextInputType.number,
      maxLengthInBarcode: 12,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 12,
    ),

    /// toolBody= 8
    GenerateBarcodeWidget(
      isTelepen: false,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: true,
      barcodeName: 'UPC-A',
      instructions: 'Only 11 Digits & 1 Check Digit'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.upcA(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
    typeKeyboard: TextInputType.number,
      maxLengthInBarcode: 11,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 11,
    ),

    /// toolBody= 9
    GenerateBarcodeWidget(
      isTelepen: false,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: true,
      barcodeName: 'EAN-5',
      instructions: 'Only 5 Digits & 1 Check Digit'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.ean5(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
      typeKeyboard: TextInputType.number,
      maxLengthInBarcode: 5,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 5,
    ),

    /// toolBody= 10
    GenerateBarcodeWidget(
      isTelepen: false,
      isItfOrCodeOrPdfOrCodabarOrAztec: true,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'ITF',
      instructions: 'Only Even Number Of Digits'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.itf(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
      typeKeyboard: TextInputType.number,
      maxLengthInBarcode: 300,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 300,
    ),

    /// toolBody= 11
    GenerateBarcodeWidget(
      isTelepen: true,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'Code - 39',
      instructions: 'Only A-Z,digit,+,-,/,.,%'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.code39(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9+/\.%-]'))],
      typeKeyboard: TextInputType.text,
      maxLengthInBarcode: 300,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 300,
    ),

    /// toolBody= 12
    GenerateBarcodeWidget(
      isTelepen: true,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'Code - 93',
      instructions: 'Only A-Z,digit,+,-,/,.,%'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.code93(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9+\-/\.%]')),],
      typeKeyboard: TextInputType.text,
      maxLengthInBarcode: 300,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 300,
    ),

    /// toolBody= 13
    GenerateBarcodeWidget(
      isTelepen: true,

      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'Code - 128',
      instructions: 'Only Text No Special Characters'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.code128(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\s]+')),],
      typeKeyboard: TextInputType.text,
      maxLengthInBarcode: 300,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 300,
    ),

    /// toolBody= 14
    GenerateBarcodeWidget(
      isTelepen: true,

      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'PDF 417',
      instructions: 'Only A-Z,digit,*,+,-,/,.,%'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.pdf417(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9*+\-/\.%]')),],
      typeKeyboard: TextInputType.text,
      maxLengthInBarcode: 300,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 300,
    ),

    /// toolBody= 15
    GenerateBarcodeWidget(
      isTelepen: true,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'Codabar',
      instructions: 'Only digits,-,:,/,+.'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.codabar(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp(r'[\d\-:/+]+')),],
      typeKeyboard: TextInputType.number,
      maxLengthInBarcode: 300,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 300,
    ),


    /// toolBody= 16
    GenerateBarcodeWidget(
      isTelepen: true,
      isItfOrCodeOrPdfOrCodabarOrAztec: false,
      isIsbnOrUpcaOrUpce: false,
      barcodeName: 'Aatec',
      instructions: 'Only A-Z,a-z,digit,*,+,-,/,.,%'.tr(),
      action: TextInputAction.done,
      barcode: Barcode.aztec(),
      inputFormatText: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9*+\-/\.%]')),],
      typeKeyboard: TextInputType.text,

      maxLengthInBarcode: 300,
      maxLinesInBarcode: 1,
      minLengthInBarcode: 300,
    ),



  ];




  RewardedAd? _rewardedAd;
  int _rewardScore =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createRewardedAd();
  }


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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        setState(() {

        });
        toolBody=-1;
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Generate'.tr(),
            style: TextStyle(
              color: Colors.black87,
              fontFamily: "Poppins",
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading:toolBody==-1?SizedBox(height: 0,):IconButton(onPressed: (){
            toolBody=-1;setState(() {

            });
          },icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
        ),
        body: toolBody==-1?
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8,left: 16,top: 16,),
                  child: Text(
                    'Barcode',
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();


                        toolBody=9;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.green.shade600,
                      toolColor: Colors.black,
                      nameOfTool: 'EAN-5',
                    ), /// body = 9
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();
                        toolBody=5;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.black87,
                      toolColor: Colors.black,
                      nameOfTool: 'EAN-8',
                    ), /// body = 5
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=10;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.blue.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'ITF',
                    ),/// body = 10
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=8;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.yellow.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'UPC-A',
                    ),/// body = 8
                  ],
                ),
                Divider(color: Colors.deepPurple.shade900,thickness: 1,indent: 50,endIndent: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=11;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.purpleAccent,
                      toolColor: Colors.black,
                      nameOfTool: 'Code 39',
                    ),/// body = 11

                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=12;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.cyanAccent.shade700,
                      toolColor: Colors.black,
                      nameOfTool: 'Code 93',
                    ),/// body = 12
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=13;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.deepOrange.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'Code 128',
                    ),/// body = 13
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=14;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.pink.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'PDF 417',
                    ),/// body = 14

                  ],
                ),
                Divider(color: Colors.deepPurple.shade900,thickness: 1,indent: 50,endIndent: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=15;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.brown.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'Codabar',
                    ),/// body = 15
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=16;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.indigoAccent,
                      toolColor: Colors.black,
                      nameOfTool: 'Aztec',
                    ),/// body = 16
                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=6;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.deepPurple.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'Telepen',
                    ),/// body = 6

                    BarcodeComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=7;
                        setState(() {

                        });
                      },
                      backgroundColor: Colors.teal,
                      toolColor: Colors.black,
                      nameOfTool: 'ISBN',
                    ),/// body = 7

                  ],
                ),
                Divider(color: Colors.deepPurple.shade900,thickness: 1,),
                Container(
                  margin: EdgeInsets.only(right: 8,left: 16,top: 16,bottom: 16),
                  child: Text(
                    'Tools',
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ToolComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=0;
                        setState(() {

                        });

                      },
                      toolIcon: Icons.text_fields,
                      backgroundColor: Colors.red.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'Text'.tr(),
                    ),///body = 0
                    ToolComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=1;
                        setState(() {

                        });
                      },
                      toolIcon: Icons.call,
                      backgroundColor: Colors.green.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'Phone'.tr(),
                    ),///body = 1
                    ToolComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=2;
                        setState(() {
                        });
                      },
                      toolIcon: Icons.email,
                      backgroundColor: Colors.blue.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'Email'.tr(),
                    ),///body = 2
                    ToolComponent(
                      function: () {
                        showRewardedAd();

                        toolBody=3;setState(() {
                        });
                      },
                      toolIcon: Icons.link,
                      backgroundColor: Colors.teal.shade900,
                      toolColor: Colors.black,
                      nameOfTool: 'Link'.tr(),
                    ),///body = 3
                  ],
                ),
              ],
            ),
          ),
        )
            :screens[toolBody],
      ),
    );
  }
}
