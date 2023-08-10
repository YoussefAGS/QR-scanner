import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/database_utils/barcode_utils.dart';
import 'package:qr_google_play/models/barcode_model.dart';
import 'package:qr_google_play/ui/tabs/history/history_result_widget.dart';

class HistoryItem extends StatefulWidget {
  MyBarcode barcode;
   HistoryItem(this.barcode, {super.key});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
late Barcode barcode1;

  @override
  void initState() {
    // TODO: implement initState
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
    if(widget.barcode.barcodeType == 'EAN-8'){
      barcode1 = Barcode.ean8();
    }
    else if(widget.barcode.barcodeType == 'EAN-5'){
      barcode1 = Barcode.ean5();
    }
    else if(widget.barcode.barcodeType == 'ISBN'){
      barcode1 = Barcode.isbn();
    }
    else if(widget.barcode.barcodeType == 'ITF'){
      barcode1 = Barcode.itf();
    }
    else if(widget.barcode.barcodeType == 'Telepen'){
      barcode1 = Barcode.telepen();
    }
    else if(widget.barcode.barcodeType == 'UPC-A'){
      barcode1 = Barcode.upcA();
    }
    else if(widget.barcode.barcodeType == 'Code 39'){
      barcode1 = Barcode.code39();
    }
    else if(widget.barcode.barcodeType == 'Code 93'){
      barcode1 = Barcode.code93();
    }
    else if(widget.barcode.barcodeType == 'Code 128'){
      barcode1 = Barcode.code128();
    }
    else if(widget.barcode.barcodeType == 'PDF 417'){
      barcode1 = Barcode.pdf417();
    }
    else if(widget.barcode.barcodeType == 'Codabar'){
      barcode1 = Barcode.codabar();
    }
    else if(widget.barcode.barcodeType == 'Aztec'){
      barcode1 = Barcode.aztec();
    }
    else if(widget.barcode.barcodeType == 'Text' ||widget.barcode.barcodeType == 'Email'||widget.barcode.barcodeType == 'Phone'||widget.barcode.barcodeType == 'Link'){
      barcode1 = Barcode.qrCode();
    }


    return InkWell(
      onTap: (){
        showRewardedAd();
        Navigator.pushNamed(context, HistoryQrResultWidget.routeName,arguments: BarcodeDetails(barcode1,widget.barcode.barcodeContent,widget.barcode.barcodeDate));
      },
      child: Container(
        height: MediaQuery.of(context).size.height*0.15,
        padding: EdgeInsets.only(top: 16,bottom: 32,),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple.shade900,width: 3),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes the position of the shadow
            ),
          ],
        ),
        width: double.infinity,
        child: ListTile(
          leading:  Container(
            width: MediaQuery.of(context).size.width*0.2,
            child: BarcodeWidget(
              barcode: barcode1, // set the barcode type to EAN-8
              data: widget.barcode.barcodeContent, // set the barcode data
            ),
          ),
          title: Center(
            child: Text(
              widget.barcode.barcodeContent,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "Poppins",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${widget.barcode.barcodeContent}')?TextDirection.rtl:TextDirection.ltr,

            ),
          ),
          subtitle: Text(
            'Date : ${widget.barcode.barcodeDate}',
            style: TextStyle(
              color: Colors.blueGrey,
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('Date : ${widget.barcode.barcodeDate}')?TextDirection.rtl:TextDirection.ltr,
          ),
          trailing: IconButton(onPressed: () async {
            showRewardedAd();
            await FirebaseFirestore.instance.disableNetwork();
            BarcodeDatabase.deleteBarcode('${widget.barcode.id}');
          },icon: Icon(Icons.delete,color: Colors.red,),),
        ),
      ),
    );
  }
}
class BarcodeDetails{
  String barcodeText;
  String barcodeDate;
  Barcode barcode;
  BarcodeDetails(this.barcode,this.barcodeText,this.barcodeDate);
}
