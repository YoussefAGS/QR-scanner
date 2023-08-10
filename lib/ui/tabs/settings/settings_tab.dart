import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/admob/ads_manager.dart';
import 'package:qr_google_play/ui/tabs/settings/feedback/feedback.dart';
import 'package:qr_google_play/ui/tabs/settings/open_source_libraries/opensource_libraries.dart';
import 'package:qr_google_play/ui/tabs/settings/privacy_and_polices/Privacy%20and%20Polices.dart';
import 'package:qr_google_play/ui/tabs/settings/language_theme/languagbottumSheet.dart';
import 'package:qr_google_play/ui/tabs/settings/language_theme/thememode.dart';
import 'package:qr_google_play/ui/tabs/settings/terms_of_use/terms_of_use.dart';
import 'package:qr_google_play/ui/tabs/settings/widgets/stting_item.dart';
import '../../../shared/constants/constant.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


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
      appBar: AppBar(
        title: Text('Settings'.tr(), style: TextStyle(
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
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'language'.tr(),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  )
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.020),
              InkWell(
                onTap: () {
                  sHowlanguagbottmeSheet();
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border:
                      Border.all(color: Colors.deepPurple.shade900)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          context.locale == Locale("en")
                              ? 'english'.tr()
                              : 'Arabic'.tr(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          )
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.deepPurple.shade900,
                      )
                    ],
                  ),
                ),
              ),
              // SizedBox(height: MediaQuery
              //     .of(context)
              //     .size
              //     .height * 0.020),
              // Text(
              //     'Theme'.tr(),
              //     style: TextStyle(
              //       color: Colors.grey.shade700,
              //       fontSize: 18,
              //       fontFamily: "Poppins",
              //       fontWeight: FontWeight.w600,
              //
              //     )
              // ),
              // SizedBox(height: MediaQuery
              //     .of(context)
              //     .size
              //     .height * 0.020),
              // InkWell(
              //   onTap: () {
              //     sHowThemebottmeSheet();
              //   },
              //   child: Container(
              //     padding: EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //         color: sharedPreferences?.get('them') == 'Light' ?
              //         Colors.white
              //             : Colors.black,
              //         borderRadius: BorderRadius.circular(12),
              //         border:
              //         Border.all(color: Colors.deepPurple.shade900)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //             '${sharedPreferences?.get('them')}'.tr(),
              //             style: TextStyle(
              //               color: Colors.black87,
              //               fontSize: 16,
              //               fontFamily: "Poppins",
              //               fontWeight: FontWeight.w600,
              //             )
              //         ),
              //         Icon(
              //           Icons.arrow_drop_down,
              //           color: Colors.deepPurple.shade900,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04),
              SettingITem(oncleck: () {
                showRewardedAd();
                Navigator.pushNamed(context, PrivacyAndPolices.routName);
              }, title: "Privacy and Polices"),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04),
              SettingITem(oncleck: () {
                showRewardedAd();
                Navigator.pushNamed(context, TermsOfUse.routeName);
              }, title: "Terms Of Use"),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04),
              SettingITem(oncleck: () {
                showRewardedAd();
                Navigator.pushNamed(context, FeedBack.routeName);
              }, title: "Feedback"),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04),
              SettingITem(oncleck: () {
                showRewardedAd();
                Navigator.pushNamed(context, OpenSourceLibraries.routeName);
              }, title: "Open Source Libraries"),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1),
              Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                      "Codeverse - Copyright 2023 Google,Inc.",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                      "All rights reserved",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sHowlanguagbottmeSheet() {
    showModalBottomSheet(context: context, builder: (context) {
      return LanguageBottomSheet();
    });
  }
  void sHowThemebottmeSheet() {
    showModalBottomSheet(context: context, builder: (context) {
      return Thememodebottom();
    });
  }
}
