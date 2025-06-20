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
    apiKey: 'AIzaSyCCrMTkRzUO3zf3QXnJ2Y04j1XIYIJauNQ',
    appId: '1:461887631374:web:52ac54a2623b3e0144cc5f',
    messagingSenderId: '461887631374',
    projectId: 'smart-hisab-44467',
    authDomain: 'smart-hisab-44467.firebaseapp.com',
    storageBucket: 'smart-hisab-44467.firebasestorage.app',
    measurementId: 'G-50R7Q5020Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZsOYiIDWViMDQyqBHkPw8Ss9tyqNZuUU',
    appId: '1:461887631374:android:760f6d3a67f01ea044cc5f',
    messagingSenderId: '461887631374',
    projectId: 'smart-hisab-44467',
    storageBucket: 'smart-hisab-44467.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDULAfPcx-AhIqdbF0Yf1i9I8hteeJ3txc',
    appId: '1:461887631374:ios:3498d83cc7167ec044cc5f',
    messagingSenderId: '461887631374',
    projectId: 'smart-hisab-44467',
    storageBucket: 'smart-hisab-44467.firebasestorage.app',
    iosBundleId: 'com.example.smartHisab',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDULAfPcx-AhIqdbF0Yf1i9I8hteeJ3txc',
    appId: '1:461887631374:ios:3498d83cc7167ec044cc5f',
    messagingSenderId: '461887631374',
    projectId: 'smart-hisab-44467',
    storageBucket: 'smart-hisab-44467.firebasestorage.app',
    iosBundleId: 'com.example.smartHisab',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCCrMTkRzUO3zf3QXnJ2Y04j1XIYIJauNQ',
    appId: '1:461887631374:web:f85e67aff86bd12644cc5f',
    messagingSenderId: '461887631374',
    projectId: 'smart-hisab-44467',
    authDomain: 'smart-hisab-44467.firebaseapp.com',
    storageBucket: 'smart-hisab-44467.firebasestorage.app',
    measurementId: 'G-9YEKW5Q4V7',
  );
}
