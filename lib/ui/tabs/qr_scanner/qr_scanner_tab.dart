import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/ui/tabs/qr_scanner/qr_result_widget.dart';
import 'package:qr_google_play/ui/tabs/qr_scanner/qr_scanner_overlay.dart';

class QrScannerTab extends StatefulWidget {
  const QrScannerTab({Key? key}) : super(key: key);

  @override
  State<QrScannerTab> createState() => _QrScannerTabState();
}

class _QrScannerTabState extends State<QrScannerTab> {

bool isScanCompleted = false;
bool isFlashOn = false;
bool isFrontCamera = false;
void closeScreen(){
  isScanCompleted = false;
}
MobileScannerController controller = MobileScannerController();


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
        centerTitle: true,
        title: Text('Qr Scanner'.tr(),style: TextStyle(
          color: Colors.black87,
          fontFamily: "Poppins",
          fontSize: 21,
          fontWeight: FontWeight.w600,
        ),),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(right: 8,left: 8,bottom:  MediaQuery.of(context).size.height*0.08),
        child: Column(children: [
        Expanded(
          flex: 4,
            child: Stack(
              children: [
                MobileScanner(
                 onDetect: (capture) {
                   final List<Barcode> barcodes = capture.barcodes;
                   for (final barcode in barcodes) {
                     if(!isScanCompleted){
                       String code = barcode.rawValue??'---';
                       isScanCompleted = true;
                       debugPrint('Barcode found! ${barcode.rawValue}');
                       showRewardedAd();
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>QrResultWidget(code, closeScreen)));
                     }
                   }
                },
                  controller: controller,
                ),
                QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
              ],
            ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            IconButton(onPressed: (){
              showRewardedAd();
              if(!isFrontCamera){
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              }
            }, icon: isFlashOn? Icon(Icons.flash_on,size: 40,color: Colors.deepPurple.shade900,):Icon(Icons.flash_off,size: 40,color: Colors.grey,)),
            // SizedBox(width: MediaQuery.of(context).size.width*0.2,),
            //
            //
            //   IconButton(onPressed: (){
            //     pickImageFromGallary();
            //   }, icon: Icon(Icons.image,size: 40,color: Colors.grey,),),


              SizedBox(width: MediaQuery.of(context).size.width*0.5,),

              IconButton(onPressed: (){
                showRewardedAd();
                setState(() {
                isFrontCamera = !isFrontCamera;
              });
              controller.switchCamera();
            }, icon: isFrontCamera?Icon(Icons.camera_front,size: 32,color: Colors.deepPurple.shade900,):Icon(Icons.camera_front,size: 40,color: Colors.grey,)),

            ],),
        )),
        ],
        ),
      ),
    );
  }


  // Future<void> pickImageFromGallary() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  // }


}


