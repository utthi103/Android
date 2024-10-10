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
    apiKey: 'AIzaSyCOyVTOIhzU6EcGrOpQFIj58vXW5OCZ5T8',
    appId: '1:72582122953:web:e0cb56d53f591915deac18',
    messagingSenderId: '72582122953',
    projectId: 'midterm1-4bd8e',
    authDomain: 'midterm1-4bd8e.firebaseapp.com',
    storageBucket: 'midterm1-4bd8e.appspot.com',
    measurementId: 'G-Z0YDWTB7CQ',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBFbCYjtmv79cYmUGunrhCsLJAkHlkFAk',
    appId: '1:72582122953:ios:99b87651064a051bdeac18',
    messagingSenderId: '72582122953',
    projectId: 'midterm1-4bd8e',
    storageBucket: 'midterm1-4bd8e.appspot.com',
    iosBundleId: 'com.example.midterm1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBFbCYjtmv79cYmUGunrhCsLJAkHlkFAk',
    appId: '1:72582122953:ios:99b87651064a051bdeac18',
    messagingSenderId: '72582122953',
    projectId: 'midterm1-4bd8e',
    storageBucket: 'midterm1-4bd8e.appspot.com',
    iosBundleId: 'com.example.midterm1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCOyVTOIhzU6EcGrOpQFIj58vXW5OCZ5T8',
    appId: '1:72582122953:web:f6a43a95cbf97b59deac18',
    messagingSenderId: '72582122953',
    projectId: 'midterm1-4bd8e',
    authDomain: 'midterm1-4bd8e.firebaseapp.com',
    storageBucket: 'midterm1-4bd8e.appspot.com',
    measurementId: 'G-TMDQFP1HPN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9m8aNoSYTDi131YfKBSaCqouHZxQU7eY',
    appId: '1:72582122953:android:84620ba35817b3fcdeac18',
    messagingSenderId: '72582122953',
    projectId: 'midterm1-4bd8e',
    storageBucket: 'midterm1-4bd8e.appspot.com',
  );

}