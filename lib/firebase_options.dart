// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyA5DgvcYzmNThqwbIurcmeOgsb1h3fqJcs',
    appId: '1:860456425765:web:b460661368ff3034ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    authDomain: 'dados-eco.firebaseapp.com',
    storageBucket: 'dados-eco.appspot.com',
    measurementId: 'G-7EHRWZHL68',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrqU60ew999-c7mGns6_UMLBAFt26rPWo',
    appId: '1:860456425765:android:41d2fff43207ee57ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    storageBucket: 'dados-eco.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByuWw26RkZIYotWkbsVMBpCV3kam63_rs',
    appId: '1:860456425765:ios:8d4d00df6f500648ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    storageBucket: 'dados-eco.appspot.com',
    iosBundleId: 'com.fox.apps.dados_eco',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByuWw26RkZIYotWkbsVMBpCV3kam63_rs',
    appId: '1:860456425765:ios:8d4d00df6f500648ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    storageBucket: 'dados-eco.appspot.com',
    iosBundleId: 'com.fox.apps.dados_eco',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA5DgvcYzmNThqwbIurcmeOgsb1h3fqJcs',
    appId: '1:860456425765:web:fdc529d9682fa6f2ba22cc',
    messagingSenderId: '860456425765',
    projectId: 'dados-eco',
    authDomain: 'dados-eco.firebaseapp.com',
    storageBucket: 'dados-eco.appspot.com',
    measurementId: 'G-SSRX1D4BE0',
  );

}