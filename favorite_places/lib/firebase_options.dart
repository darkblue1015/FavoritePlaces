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
    apiKey: 'AIzaSyAjN_590FERkl5rKti3hHgEmKRIWCvqvK0',
    appId: '1:716831213443:web:88ebe4df9bd81e350d58b6',
    messagingSenderId: '716831213443',
    projectId: 'favorite-places-8934d',
    authDomain: 'favorite-places-8934d.firebaseapp.com',
    storageBucket: 'favorite-places-8934d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATjbcwGyYA7KXS82q8keF1mfHhFasZXVE',
    appId: '1:716831213443:android:bd320626db21bd360d58b6',
    messagingSenderId: '716831213443',
    projectId: 'favorite-places-8934d',
    storageBucket: 'favorite-places-8934d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYl_x4W6SM1EdqctRZYwgcT0vNo_wuP2k',
    appId: '1:716831213443:ios:ab169fc1a3b5fe470d58b6',
    messagingSenderId: '716831213443',
    projectId: 'favorite-places-8934d',
    storageBucket: 'favorite-places-8934d.appspot.com',
    iosBundleId: 'com.example.favoritePlaces',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYl_x4W6SM1EdqctRZYwgcT0vNo_wuP2k',
    appId: '1:716831213443:ios:29eea28ba28a55da0d58b6',
    messagingSenderId: '716831213443',
    projectId: 'favorite-places-8934d',
    storageBucket: 'favorite-places-8934d.appspot.com',
    iosBundleId: 'com.example.favoritePlaces.RunnerTests',
  );
}
