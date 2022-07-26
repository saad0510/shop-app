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
    apiKey: 'AIzaSyAtfZp2ODwv9tlt6j7Bd6No1rBS9ivbHb8',
    appId: '1:590273361491:web:8c326bf89595700a52b8a6',
    messagingSenderId: '590273361491',
    projectId: 'shopping-app-1234',
    authDomain: 'shopping-app-1234.firebaseapp.com',
    storageBucket: 'shopping-app-1234.appspot.com',
    measurementId: 'G-BELMPPY29B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6Z7SHflT_2pInTmalgnrzCWbd7fHxCIA',
    appId: '1:590273361491:android:0eda43dc49d04e0052b8a6',
    messagingSenderId: '590273361491',
    projectId: 'shopping-app-1234',
    storageBucket: 'shopping-app-1234.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1001v9HLWpsnB5jDhxDz0dswHYBBaoQw',
    appId: '1:590273361491:ios:32b5e766621687e552b8a6',
    messagingSenderId: '590273361491',
    projectId: 'shopping-app-1234',
    storageBucket: 'shopping-app-1234.appspot.com',
    iosClientId: '590273361491-t03qo9n9ljv4vch6laor4idtiocl6lgl.apps.googleusercontent.com',
    iosBundleId: 'com.example.shoppingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD1001v9HLWpsnB5jDhxDz0dswHYBBaoQw',
    appId: '1:590273361491:ios:32b5e766621687e552b8a6',
    messagingSenderId: '590273361491',
    projectId: 'shopping-app-1234',
    storageBucket: 'shopping-app-1234.appspot.com',
    iosClientId: '590273361491-t03qo9n9ljv4vch6laor4idtiocl6lgl.apps.googleusercontent.com',
    iosBundleId: 'com.example.shoppingApp',
  );
}
