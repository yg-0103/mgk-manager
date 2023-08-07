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
    apiKey: 'AIzaSyADmMMfq4Cu7g5ibVqp51iDyL5EZh3dSEU',
    appId: '1:319538555456:web:0986c5000fbcbfd4f74da5',
    messagingSenderId: '319538555456',
    projectId: 'mgk-manager',
    authDomain: 'mgk-manager.firebaseapp.com',
    databaseURL: 'https://mgk-manager-default-rtdb.firebaseio.com',
    storageBucket: 'mgk-manager.appspot.com',
    measurementId: 'G-B07SMJYKQH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvUQ8M6LY0JUKC47sKLY8ehtCFMel_n3I',
    appId: '1:319538555456:android:7306febafbcbdb92f74da5',
    messagingSenderId: '319538555456',
    projectId: 'mgk-manager',
    databaseURL: 'https://mgk-manager-default-rtdb.firebaseio.com',
    storageBucket: 'mgk-manager.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBoMLzSCJ-0Ehy8oaeTAZBmI17ZALITv8',
    appId: '1:319538555456:ios:d9c11fdbd3c44daef74da5',
    messagingSenderId: '319538555456',
    projectId: 'mgk-manager',
    databaseURL: 'https://mgk-manager-default-rtdb.firebaseio.com',
    storageBucket: 'mgk-manager.appspot.com',
    iosClientId: '319538555456-ue6p0lif42rqs77fp69b0ds8afkfbi5f.apps.googleusercontent.com',
    iosBundleId: 'com.example.mgkManager',
  );
}
