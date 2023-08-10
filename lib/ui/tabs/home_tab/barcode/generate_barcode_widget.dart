import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/database_utils/barcode_utils.dart';
import 'package:qr_google_play/models/barcode_model.dart';
import 'package:qr_google_play/shared/components/alert_ok_dialog_component.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:pdf/widgets.dart' as pw;

class GenerateBarcodeWidget extends StatefulWidget {
  String barcodeName;
  String instructions;
  TextInputType typeKeyboard;
  TextInputAction action;
  List<TextInputFormatter> inputFormatText;
  Barcode barcode;
  int maxLengthInBarcode;
  int maxLinesInBarcode;
  int minLengthInBarcode;
  bool isIsbnOrUpcaOrUpce;
  bool isItfOrCodeOrPdfOrCodabarOrAztec;
  bool isTelepen;

  // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),

  GenerateBarcodeWidget({
    super.key,
    required this.maxLinesInBarcode,
    required this.isIsbnOrUpcaOrUpce,
    required this.isItfOrCodeOrPdfOrCodabarOrAztec,
    required this.isTelepen,
    required this.maxLengthInBarcode,
    required this.minLengthInBarcode,
    required this.barcode,
    required this.inputFormatText,
    required this.barcodeName,
    required this.instructions,
    required this.action,
    required this.typeKeyboard,
  });

  @override
  State<GenerateBarcodeWidget> createState() => _GenerateBarcodeWidgetState();
}

class _GenerateBarcodeWidgetState extends State<GenerateBarcodeWidget> {
  TextEditingController txtController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();
  String barcodeText = '';
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

  DateTime selectedTime = DateTime.now();
  late bool isOn = false;


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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.barcodeName,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: "Poppins",
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isOn == true?
              Column(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: BarcodeWidget(
                      barcode: widget
                          .barcode, // set the barcode type to EAN-8
                      data: barcodeText, // set the barcode data
                      width: 300, // set the barcode width
                      height: 180, // set the barcode height
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                showRewardedAd();
                                _captureAndSaveImage(context);
                              },
                              icon: Icon(
                                Icons.download,
                                color: Colors.deepPurple.shade900,
                                size: 32,
                              ))),
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                showRewardedAd();

                                displayPdfForQr(
                                    false, widget.barcode);
                              },
                              icon: Icon(
                                Icons.picture_as_pdf,
                                color: Colors.deepPurple.shade900,
                                size: 32,
                              ))),
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                showRewardedAd();
                                convertWidgetToImage();
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.deepPurple.shade900,
                                size: 32,
                              ))),
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                showRewardedAd();
                                displayPdfForQr(true, widget.barcode);
                              },
                              icon: Icon(
                                Icons.print,
                                color: Colors.deepPurple.shade900,
                                size: 32,
                              ))),
                    ],
                  ),
                ],
              )
                  :SizedBox(height: 0,),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                '${widget.instructions} :',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),

              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                cursorColor: Colors.deepPurple.shade900,
                maxLines: widget.maxLinesInBarcode,
                onChanged: (txt) {
                  setState(() {
                    barcodeText = txt;
                  });
                },
                inputFormatters: widget.inputFormatText,
                keyboardType: widget.typeKeyboard,
                textInputAction: widget.action,
                controller: txtController,
                maxLength: widget.maxLengthInBarcode,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple.shade900),
                  ),
                  prefixIcon: Container(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/barcode.png',
                        width: 15,
                        height: 15,
                      )),
                  suffixIcon: IconButton(onPressed: (){
                    showRewardedAd();
                    Clipboard.setData(ClipboardData(text: barcodeText));
                  },icon: Icon(Icons.copy,color: Colors.deepPurple.shade900,size: 28,),),
                  hintText: 'Product Code',
                  labelText: 'Product Code',
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
                            top: 16,
                            bottom: 16)),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.deepPurple.shade900),
                    visualDensity: VisualDensity.comfortable),
                onPressed: () {
                  showRewardedAd();
                    checkPermit();
                },
                child: Center(
                  child: Text(
                    'Generate Barcode',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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

  Future<void> checkPermit() async {
    await FirebaseFirestore.instance.disableNetwork();
    if(widget.barcodeName == 'EAN-8' || widget.barcodeName == 'EAN-5'
        || widget.barcodeName == 'ISBN'  || widget.barcodeName == 'UPC-A' )
    {
      if(widget.maxLengthInBarcode == barcodeText.length){
        MyBarcode barcode = MyBarcode(
            id: '',
            barcodeType: widget.barcodeName,
            barcodeContent: barcodeText,
            barcodeDate: '${selectedTime.day}/${selectedTime.month}/${selectedTime.year}'
        );
        BarcodeDatabase.addBarcodeToFirebase(barcode);
        setState(() {
          isOn = true;
        });
      }else{
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (BuildContext){
          return AlertDialogOkComponent(
            alertTitle: 'Incorrect',
            alertContent: 'Please, Enter Barcode',
          );
        });
      }
    }else if(widget.barcodeName == 'ITF'){
      if(barcodeText.length % 2 == 0){
        MyBarcode barcode = MyBarcode(
            id: '',
            barcodeType: widget.barcodeName,
            barcodeContent: barcodeText,
            barcodeDate: '${selectedTime.day}/${selectedTime.month}/${selectedTime.year}'
        );
        BarcodeDatabase.addBarcodeToFirebase(barcode);
        setState(() {
          isOn = true;
        });
      }else{
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext){
              return AlertDialogOkComponent(
                alertTitle: 'Incorrect',
                alertContent: barcodeText.isEmpty?'Please, Enter Barcode.':'Please, Enter Only Even Number Of Digits.',
              );
            });
      }
    }else{
      if(barcodeText.isEmpty){
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
            barcodeType: widget.barcodeName,
            barcodeContent: barcodeText,
            barcodeDate: '${selectedTime.day}/${selectedTime.month}/${selectedTime.year}'
        );
        BarcodeDatabase.addBarcodeToFirebase(barcode);
        setState(() {
          isOn = true;
        });
      }
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
              "Barcode saved to gallery.".tr(),
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

  void convertWidgetToImage() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/BarcodeImage.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path], text: '');
      }
    });
  }

  Future<void> displayPdfForQr(bool isPrint, pw.Barcode barcode) async {
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
                barcode: barcode,
                data: barcodeText,
                height: 400,
                width: 400,
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file1 = File('${output.path}/Barcode.pdf');
    await file1.writeAsBytes(await pdf.save());

    if (isPrint) {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
    } else {
      /// Share Plugin
      await Share.shareFiles([
        file1.path,
      ], text: '');
    }
  }
}
