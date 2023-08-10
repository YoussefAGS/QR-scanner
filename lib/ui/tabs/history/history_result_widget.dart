import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/ui/tabs/history/history_item.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:pdf/widgets.dart' as pw;


class HistoryQrResultWidget extends StatefulWidget {
  static const String routeName = 'History Qr Result Widget';
  const HistoryQrResultWidget({Key? key}) : super(key: key);

  @override
  State<HistoryQrResultWidget> createState() => _HistoryQrResultWidgetState();
}

class _HistoryQrResultWidgetState extends State<HistoryQrResultWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  static late pw.Font arFont;

  init() async {
    arFont = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Cairo/static/Cairo-Bold.ttf'));
  }


late BarcodeDetails nBarcode;

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
  Widget build(BuildContext context) {
     nBarcode = ModalRoute.of(context)!.settings.arguments as BarcodeDetails;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,) ,
        ),
        title: Text('Barcode',style: TextStyle(
          color: Colors.black87,
          letterSpacing: 1,
          fontWeight: FontWeight.w700,
          fontSize: 21,
          fontFamily: "Poppins",
        ),
        ),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: BarcodeWidget(
                          barcode: nBarcode.barcode, // set the barcode type to EAN-8
                          data: nBarcode.barcodeText, // set the barcode data
                          width: 300, // set the barcode width
                          height: 180, // set the barcode height
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    _captureAndSaveImage(context);
                                  },
                                  icon: Icon(
                                    Icons.download,
                                    size: 32,
                                  ))),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    displayPdfForQr(
                                        false, );
                                  },
                                  icon: Icon(
                                    Icons.picture_as_pdf,
                                    size: 32,
                                  ))),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    convertWidgetToImage();
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    size: 32,
                                  ))),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    displayPdfForQr(true,);
                                  },
                                  icon: Icon(
                                    Icons.print,
                                    size: 32,
                                  ))),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Container(
                    padding: EdgeInsets.only(right: 16,left: 16,),
                    child: Center(
                      child: Text(nBarcode.barcodeText,style: TextStyle(
                          color: Colors.deepPurple.shade900,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis
                      ),
                        maxLines: 10,
                      ),
                    ),
                  ),
                ],
              ),
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
                data: nBarcode.barcodeText,
                height: 400,
                width: 400,
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

  Future<void> _captureAndSaveImage(BuildContext context) async {
    try {
      // Capture the QR code image
      Uint8List? imageUint8List = await screenshotController.capture();
      if (imageUint8List != null) {
        // Save the QR code image to the gallery
        final result = await ImageGallerySaver.saveImage(imageUint8List);
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Barcode saved to gallery.",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600),
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Text(
              "Failed to save Barcode.".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600),
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade700,
          content: Text(
            "Failed to capture Barcode image.".tr(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
        ));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade700,
        content: Text(
          "Failed to save Barcode.".tr(),
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
        ),
      ));
    }
  }

}
