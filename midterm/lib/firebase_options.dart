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
    apiKey: 'AIzaSyDHkFty2mqZD7kshXHs_kioqVEPCNH9maI',
    appId: '1:912162193009:web:302f80d5d5b2e50d8665d0',
    messagingSenderId: '912162193009',
    projectId: 'midterm-c6e80',
    authDomain: 'midterm-c6e80.firebaseapp.com',
    storageBucket: 'midterm-c6e80.appspot.com',
    measurementId: 'G-XRLNKP5DG2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAYifQ6ZN6Qnjo6UOOITrOdXDhc4AHiwk',
    appId: '1:912162193009:android:6a41dca09fa93da68665d0',
    messagingSenderId: '912162193009',
    projectId: 'midterm-c6e80',
    storageBucket: 'midterm-c6e80.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC52_MWpr4hRwXY8bZMI27u9WIGWgVXZv4',
    appId: '1:912162193009:ios:c0a8567ef877c39a8665d0',
    messagingSenderId: '912162193009',
    projectId: 'midterm-c6e80',
    storageBucket: 'midterm-c6e80.appspot.com',
    iosBundleId: 'com.example.midterm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC52_MWpr4hRwXY8bZMI27u9WIGWgVXZv4',
    appId: '1:912162193009:ios:c0a8567ef877c39a8665d0',
    messagingSenderId: '912162193009',
    projectId: 'midterm-c6e80',
    storageBucket: 'midterm-c6e80.appspot.com',
    iosBundleId: 'com.example.midterm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDHkFty2mqZD7kshXHs_kioqVEPCNH9maI',
    appId: '1:912162193009:web:302f80d5d5b2e50d8665d0',
    messagingSenderId: '912162193009',
    projectId: 'midterm-c6e80',
    authDomain: 'midterm-c6e80.firebaseapp.com',
    storageBucket: 'midterm-c6e80.appspot.com',
    measurementId: 'G-XRLNKP5DG2',
  );

}