import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/ui/tabs/ads/ads_wiget.dart';
import 'package:qr_google_play/ui/tabs/history/history_tab.dart';
import 'package:qr_google_play/ui/tabs/home_tab/home_tab.dart';
import 'package:qr_google_play/ui/tabs/qr_scanner/qr_scanner_tab.dart';
import 'package:qr_google_play/ui/tabs/settings/settings_tab.dart';

class HomeWidget extends StatefulWidget {
  static const String routeName = 'Home Widget';
   const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int index = 2;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final items = <Widget>[
    const Icon(Icons.home, size: 30,color: Colors.white,),
    const Icon(Icons.history, size: 30,color: Colors.white,),
    const Icon(Icons.qr_code_scanner, size: 30,color: Colors.white,),
    const Icon(Icons.ads_click, size: 30,color: Colors.white,),
    const Icon(Icons.settings, size: 30,color: Colors.white,),
  ];

  final screens = [
    HomeTab(),
    HistoryTab(),
    QrScannerTab(),
    AdsTab(),
    Settings(),
  ];

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  int _rewardScore =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createBannerAd();
    _createinterstitialAd();
    _createRewardedAd();
  }

  void _createBannerAd(){
    _bannerAd = BannerAd(size: AdSize.fullBanner,
        adUnitId: AdManager.bannerAdUnitId!,
        listener: AdManager.bannerAdListener,
        request: const AdRequest()
    )..load();
  }

  void _createinterstitialAd(){
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad)=>_interstitialAd=ad,
          onAdFailedToLoad: (LoadAdError error)=> _interstitialAd =null,
        ),
    );
  }
  void showInterstitialAd(){
    if(_interstitialAd != null){
      _interstitialAd!.fullScreenContentCallback=FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          _createinterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          _createinterstitialAd();

        }
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
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
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.blue,
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _bannerAd == null ? Container()
                :
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16),
              height: 52,
             child: AdWidget(ad: _bannerAd!),
            ),
            CurvedNavigationBar(
              key: _bottomNavigationKey,
              backgroundColor: Colors.transparent,
              color: Colors.deepPurple.shade900,
              buttonBackgroundColor: Colors.deepPurple.shade900,
              index: index,
              height: 60.0,
              items: items,
              animationCurve: Curves.easeInOut,
              animationDuration:const Duration(milliseconds: 300) ,
              onTap: (index) =>setState(() => this.index= index),

            ),
          ],
        ),
        body: screens[index],
      ),
    );
  }
}

