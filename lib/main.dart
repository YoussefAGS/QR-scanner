import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_google_play/firebase_options.dart';
import 'package:qr_google_play/shared/constants/constant.dart';
import 'package:qr_google_play/shared/styles/mytheme.dart';
import 'package:qr_google_play/ui/bloc/theam/theme__bloc.dart';
import 'package:qr_google_play/ui/home/home_view.dart';
import 'package:qr_google_play/ui/tabs/history/history_result_widget.dart';
import 'package:qr_google_play/ui/tabs/settings/feedback/feedback.dart';
import 'package:qr_google_play/ui/tabs/settings/open_source_libraries/opensource_libraries.dart';
import 'package:qr_google_play/ui/tabs/settings/privacy_and_polices/Privacy%20and%20Polices.dart';
import 'package:qr_google_play/ui/tabs/settings/terms_of_use/terms_of_use.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(persistenceEnabled: true);
  firestore.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(EasyLocalization(
      supportedLocales: const [
        Locale("en",),
        Locale("ar", "EG"),
      ],
      startLocale: const Locale("en",),
      saveLocale: true,
      path: 'assets/translations',
      fallbackLocale: const Locale("en",),
      child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  ThemeData themeData = ThemeData.light();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc()..add(InitialThemeEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          if (themeState is ThemeDark) {
            themeData = themeState.theme;
          } else if (themeState is ThemeLight) {
            themeData = themeState.theme;
          }

          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            color: Colors.transparent,
            debugShowCheckedModeBanner: false,

            routes: {
              ///todo: Home Routes:-
              HomeWidget.routeName: (_) => HomeWidget(),
              PrivacyAndPolices.routName:(_)=>PrivacyAndPolices(),
              TermsOfUse.routeName:(_)=>TermsOfUse(),
              FeedBack.routeName:(_)=>FeedBack(),
              OpenSourceLibraries.routeName :(_)=>OpenSourceLibraries(),
              HistoryQrResultWidget.routeName : (_)=>HistoryQrResultWidget(),
            },

            initialRoute: HomeWidget.routeName,
            theme:themeData,
            darkTheme: MyTheme.Light,
            themeMode: ThemeMode.light,
          );
        },
      ),
    );
  }
}

