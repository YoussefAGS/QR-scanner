// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDEZSqhl4OG5S9uROvJ_uTPq43qHT3bUhg',
    appId: '1:458766866889:web:83c7638120f2fb179e7018',
    messagingSenderId: '458766866889',
    projectId: 'qr-scanner-code--play',
    authDomain: 'qr-scanner-code--play.firebaseapp.com',
    storageBucket: 'qr-scanner-code--play.appspot.com',
    measurementId: 'G-5K7NR6HP55',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeKqrnHighy7bCdfNnWSOq-CAPvmI6aYc',
    appId: '1:458766866889:android:f48afcf5a664bab39e7018',
    messagingSenderId: '458766866889',
    projectId: 'qr-scanner-code--play',
    storageBucket: 'qr-scanner-code--play.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0uKnHVhh2jw5mottrN59VkzXISeUUnik',
    appId: '1:458766866889:ios:8c724945785dff349e7018',
    messagingSenderId: '458766866889',
    projectId: 'qr-scanner-code--play',
    storageBucket: 'qr-scanner-code--play.appspot.com',
    iosClientId: '458766866889-uldjk3heaabd66a3l577serpvgs5qsnd.apps.googleusercontent.com',
    iosBundleId: 'com.example.qrGooglePlay',
  );
}
