import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager{

  /// ----------- Start -------------
  static String? get appId{
    if(Platform.isAndroid){
      return "ca-app-pub-3940256099942544~5662855259";
    }else if(Platform.isIOS){
      return "ca-app-pub-3940256099942544~5662855259";
    }
    return null;
  }
  static String? get bannerAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-3940256099942544/6300978111";
    }else if(Platform.isIOS){
      return "ca-app-pub-3940256099942544/6300978111";
    }
    return null;
  }
  static String? get nativeAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-3940256099942544~5662855259";
    }else if(Platform.isIOS){
      return "ca-app-pub-3940256099942544~5662855259";
    }
    return null;
  }
  static String? get interstitialAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-3940256099942544/1033173712";
    }else if(Platform.isIOS){
      return "ca-app-pub-3940256099942544/1033173712";
    }
    return null;
  }

  static String? get rewardedAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-3940256099942544/5224354917";
    }else if(Platform.isIOS){
      return "ca-app-pub-3940256099942544/5224354917";
    }

    return null;
  }


  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad)=>debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad,error){
      ad.dispose();
      debugPrint('Ad Failed to load $error');
    },
    onAdOpened: (ad)=>debugPrint('Ad Opened'),
    onAdClosed: (ad)=>debugPrint('Ad Closed'),
  );
  /// ----------- End -------------






}