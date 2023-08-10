import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:pdf/widgets.dart' as pw;


class QrResultWidget extends StatefulWidget {
  final String code;
  final Function() closeScreen;
   QrResultWidget(this.code,this.closeScreen,{Key? key}) : super(key: key);

  @override
  State<QrResultWidget> createState() => _QrResultWidgetState();
}

class _QrResultWidgetState extends State<QrResultWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  static late pw.Font arFont;

  init() async {
    arFont = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Cairo/static/Cairo-Bold.ttf'));
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
    _createBannerAd();
    _createRewardedAd();
  }


  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  int _rewardScore =0;



  void _createBannerAd(){
    _bannerAd = BannerAd(size: AdSize.fullBanner,
        adUnitId: AdManager.bannerAdUnitId!,
        listener: AdManager.bannerAdListener,
        request: const AdRequest()
    )..load();
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
  void dispose() {
    // TODO: implement dispose
    widget.closeScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            widget.closeScreen();
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,) ,
        ),
        title: Text('Qr Code Preview',style: TextStyle(
          color: Colors.black87,
          letterSpacing: 1,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          fontFamily: "Poppins",
        ),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar:  _bannerAd == null ? Container(
        color: Colors.green,height: 52,
      )
          :
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16),
        height: 80,
        child: AdWidget(ad: _bannerAd!),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.1,
                bottom:MediaQuery.of(context).size.width*0.05,
            ),
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.cyan, Colors.blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: QrImageView(
                            data: widget.code,
                            version: QrVersions.auto,
                            dataModuleStyle: QrDataModuleStyle(
                                color: Theme.of(context).colorScheme.primary),
                            constrainErrorBounds: true,
                            eyeStyle: QrEyeStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                eyeShape: QrEyeShape.square),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(6),
                            errorCorrectionLevel: 1,
                            foregroundColor: Colors.black,
                            errorStateBuilder: (context, error) =>
                            const Text('errorsssss'),
                            semanticsLabel: '1',
                            size: 200,
                            gapless: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width*0.16,
                          left: MediaQuery.of(context).size.width*0.16,
                        ),
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: IconButton(onPressed: (){
                              showRewardedAd();
                              displayPdfForQr(false);
                            },icon: Icon(Icons.picture_as_pdf,color: Colors.white,size: 28,))),
                            Expanded(
                              child: IconButton(onPressed: (){
                                showRewardedAd();
                                convertWidgetToImage();
                              },icon: Icon(Icons.share,color: Colors.white,size: 28,)),
                            ),
                            Expanded(
                              child: IconButton(onPressed: (){
                                showRewardedAd();
                                Clipboard.setData(ClipboardData(text: widget.code));
                              },icon: Icon(Icons.copy,color: Colors.white,size: 28,)),
                            ),
                            Expanded(child: IconButton(onPressed: (){
                              showRewardedAd();
                              displayPdfForQr(true);
                            },icon: Icon(Icons.print,color: Colors.white,size: 28,))),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  ],),
                  Container(
                    padding: EdgeInsets.only(right: 16,left: 16,),
                    child: Center(
                      child: Text('${widget.code}',style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis
                      ),
                        textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${widget.code}')?TextDirection.rtl :TextDirection.ltr,
                        maxLines: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          Container(
            padding: EdgeInsets.only(right: 16,left: 16,),
            child: Text('Amazing Tools',style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              fontFamily: "Poppins",
            ),
              textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${widget.code}')?TextDirection.rtl :TextDirection.ltr,
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }
  void convertWidgetToImage() async {
    await screenshotController.capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/QrImage.png').create();
        await imagePath.writeAsBytes(image);
        /// Share Plugin
        await Share.shareFiles([imagePath.path],text: '');

      }
    });
  }

  Future<void> displayPdfForQr(bool isPrint) async {
      final pdf = pw.Document();
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            theme: pw.ThemeData.withFont(base: arFont),
            build: (context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.BarcodeWidget(
                    color: PdfColors.black,
                    barcode: pw.Barcode.qrCode(),
                    data: widget.code,
                    height: 700,
                    width: 900,
                  ),
                ],
              );
            },
          ),
        );

        final output = await getTemporaryDirectory();
        final file1 = File('${output.path}/Qr Code.pdf');
        await file1.writeAsBytes(await pdf.save());

        if(isPrint){
          await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => pdf.save());

        }else{
          /// Share Plugin
          await Share.shareFiles([file1.path,],text: '');

        }



  }
}
