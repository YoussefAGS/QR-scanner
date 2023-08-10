import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/admob/ads_manager.dart';

class AdsTab extends StatefulWidget{
  const AdsTab({Key? key}) : super(key: key);

  @override
  State<AdsTab> createState() => _AdsTabState();
}

class _AdsTabState extends State<AdsTab> {
  InterstitialAd? _interstitialAd;
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
        onUserEarnedReward: (ad,reward)=>setState(() => _rewardScore =_rewardScore+10),
      );
      _rewardedAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ADS', style: TextStyle(
          color: Colors.black87,
          fontFamily: "Poppins",
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.deepPurple.shade900,
              child: Row(
                children: [
                  Expanded(child: Center(
                    child: Text('Score   :   $_rewardScore',style: TextStyle(
                      color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold
                    ),),
                  )),
                ],
              ),
            ),


            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.2,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade900
                    , Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(Icons.monetization_on,color: Colors.white,size: 80,),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Container(
              margin: EdgeInsets.only(right: 16,left: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.only(
                            right:
                            MediaQuery.of(context)
                                .size
                                .width *
                                0.1,
                            left: MediaQuery.of(context)
                                .size
                                .width *
                                0.1,
                            top: 16,
                            bottom: 16)),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.deepPurple.shade900),
                    visualDensity: VisualDensity.comfortable),
                onPressed: (){
                  _rewardScore +=10;
                  showRewardedAd();
                },
                child: Center(
                  child: Text(
                    'Watch Ad Score +20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),


            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.2,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.green
                    , Colors.greenAccent.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(Icons.monetization_on,color: Colors.white,size: 80,),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Container(
              margin: EdgeInsets.only(right: 16,left: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.only(
                            right:
                            MediaQuery.of(context)
                                .size
                                .width *
                                0.1,
                            left: MediaQuery.of(context)
                                .size
                                .width *
                                0.1,
                            top: 16,
                            bottom: 16)),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.deepPurple.shade900),
                    visualDensity: VisualDensity.comfortable),
                onPressed: showRewardedAd,
                child: Center(
                  child: Text(
                    'Watch Ad Score +10',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),




          ],),
      ),
    );
  }
}
