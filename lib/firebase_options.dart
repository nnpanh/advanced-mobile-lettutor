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
    apiKey: 'AIzaSyA6taw2GVow_SsS77JZIIWUUQ_C2_EIlf8',
    appId: '1:547349657894:web:9a987a8434f49a6e0969e7',
    messagingSenderId: '547349657894',
    projectId: 'lettutor-a6aba',
    authDomain: 'lettutor-a6aba.firebaseapp.com',
    storageBucket: 'lettutor-a6aba.appspot.com',
    measurementId: 'G-7XWQM6TRHJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQsGWZdzjcYS1OwvvUME-EVb37htwftOs',
    appId: '1:547349657894:android:8488e17931dbdd940969e7',
    messagingSenderId: '547349657894',
    projectId: 'lettutor-a6aba',
    storageBucket: 'lettutor-a6aba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMRz_F-Ze40DEKtGXMxh2zY9_5v3LE9I4',
    appId: '1:547349657894:ios:8fb6253143405ad10969e7',
    messagingSenderId: '547349657894',
    projectId: 'lettutor-a6aba',
    storageBucket: 'lettutor-a6aba.appspot.com',
    iosClientId: '547349657894-0rfsc98du2el5l4freg5r1ffv1o50f2q.apps.googleusercontent.com',
    iosBundleId: 'com.example.lettutor',
  );
}
