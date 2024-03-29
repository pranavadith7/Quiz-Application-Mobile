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
        return macos;
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
    apiKey: 'AIzaSyAI5OO4ClxdvdO5Bl2-w3s0UEcUK-Oca1w',
    appId: '1:946683088707:web:6efe2a677ddfadccd229f6',
    messagingSenderId: '946683088707',
    projectId: 'quiz-application-49b65',
    authDomain: 'quiz-application-49b65.firebaseapp.com',
    databaseURL: 'https://quiz-application-49b65-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quiz-application-49b65.appspot.com',
    measurementId: 'G-RE09DXH3N0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWpjnC_RUXsqpLgmsqml_7uFJfXFrwaH0',
    appId: '1:946683088707:android:08c9205db93a38b9d229f6',
    messagingSenderId: '946683088707',
    projectId: 'quiz-application-49b65',
    databaseURL: 'https://quiz-application-49b65-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quiz-application-49b65.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMunyK2O7UOKA4_W2JTA4ddALSFi2M5VE',
    appId: '1:946683088707:ios:7160ea9156d454ded229f6',
    messagingSenderId: '946683088707',
    projectId: 'quiz-application-49b65',
    databaseURL: 'https://quiz-application-49b65-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quiz-application-49b65.appspot.com',
    iosBundleId: 'com.example.quizApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMunyK2O7UOKA4_W2JTA4ddALSFi2M5VE',
    appId: '1:946683088707:ios:c29682b5071237f3d229f6',
    messagingSenderId: '946683088707',
    projectId: 'quiz-application-49b65',
    databaseURL: 'https://quiz-application-49b65-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quiz-application-49b65.appspot.com',
    iosBundleId: 'com.example.quizApplication.RunnerTests',
  );
}
