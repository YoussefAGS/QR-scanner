
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:share/share.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../admob/ads_manager.dart';



class GenerateQrCodeWidget extends StatefulWidget {

   String qrData="";


   GenerateQrCodeWidget({required this.qrData});

  @override
  State<GenerateQrCodeWidget> createState() => _GenerateQrCodeWidgetState();
}

class _GenerateQrCodeWidgetState extends State<GenerateQrCodeWidget> {
  final ScreenshotController screenshotController = ScreenshotController();
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
    _createRewardedAd();
  }


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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Screenshot(
          controller: screenshotController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade900
                      , Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: QrImageView(
                  data: widget.qrData,
                  version: QrVersions.auto,
                  dataModuleStyle: QrDataModuleStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary),
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
                  semanticsLabel: '${widget.qrData}',
                  size: 220,
                  gapless: true,
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width*0.01,
            left: MediaQuery.of(context).size.width*0.01,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: IconButton( onPressed: () {
                showRewardedAd();
                _captureAndSaveImage(context);
                },icon: Icon(Icons.download,color: Colors.deepPurple.shade900,size: 32,))),
              Expanded(child: IconButton(onPressed: (){
                showRewardedAd();
                displayPdfForQr(false);
              },icon: Icon(Icons.picture_as_pdf,color: Colors.deepPurple.shade900,size: 32,))),
              Expanded(
                child: IconButton(onPressed: (){
                  showRewardedAd();
                  convertWidgetToImage();
                },icon: Icon(Icons.share,color: Colors.deepPurple.shade900,size: 32,)),
              ),
              Expanded(child: IconButton(onPressed: (){
                showRewardedAd();
                displayPdfForQr(true);
              },icon: Icon(Icons.print,color: Colors.deepPurple.shade900,size: 32,))),
            ],
          ),
        ),
      ],
    );
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
              "QR Code Saved To Gallery.".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600
              ),
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade700,
            content: Text(
              "Failed to save QR Code.".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600
              ),
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade700,
          content: Text(
            "Failed to capture QR Code image.".tr(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600
            ),
          ),
        ));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade700,
        content: Text(
          "Failed to save QR Code.".tr(),
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600
          ),
        ),
      ));
    }
  }



  void convertWidgetToImage() async {
    await screenshotController.capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/BarcodeImage.png').create();
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
                data: widget.qrData,
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
}
