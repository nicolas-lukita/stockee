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
    apiKey: 'AIzaSyDV-qVOY3Dn4ln7fuyoIraXeaC0sXg2nBw',
    appId: '1:449419668237:web:3cf34a0559be26d4229e44',
    messagingSenderId: '449419668237',
    projectId: 'stockee-654ee',
    authDomain: 'stockee-654ee.firebaseapp.com',
    storageBucket: 'stockee-654ee.appspot.com',
    measurementId: 'G-TVC9RR57QJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7ztRKMNwS4gL37cA0DM3zkL_EwirOJHA',
    appId: '1:449419668237:android:4ae5226bcf10ddba229e44',
    messagingSenderId: '449419668237',
    projectId: 'stockee-654ee',
    storageBucket: 'stockee-654ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDM7IgOtdIalGutH32FztlaQQD_poquYSE',
    appId: '1:449419668237:ios:04a3131d04c2104e229e44',
    messagingSenderId: '449419668237',
    projectId: 'stockee-654ee',
    storageBucket: 'stockee-654ee.appspot.com',
    iosClientId:
        '449419668237-mvr0k7om4vmtks796grdmhvuvqdr2e8t.apps.googleusercontent.com',
    iosBundleId: 'com.example.stockee',
  );
}