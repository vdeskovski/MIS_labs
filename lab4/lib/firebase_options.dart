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
    apiKey: 'AIzaSyDPaD0X09gM2fXW0XsHbBAQgr206HatAHE',
    appId: '1:360679186391:web:77dacc2e593cb5dd5a7592',
    messagingSenderId: '360679186391',
    projectId: 'mislab4',
    authDomain: 'mislab4.firebaseapp.com',
    storageBucket: 'mislab4.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOMK0lgP3e3gkLfL2VjDU4VJuXO5kKVg8',
    appId: '1:360679186391:android:c80fbc8f41e260e25a7592',
    messagingSenderId: '360679186391',
    projectId: 'mislab4',
    storageBucket: 'mislab4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgr12ibgw-pNM5RBOzjb8YCJteUG7dEnk',
    appId: '1:360679186391:ios:a8e75a4eb559bb5d5a7592',
    messagingSenderId: '360679186391',
    projectId: 'mislab4',
    storageBucket: 'mislab4.firebasestorage.app',
    iosBundleId: 'com.example.lab4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgr12ibgw-pNM5RBOzjb8YCJteUG7dEnk',
    appId: '1:360679186391:ios:a8e75a4eb559bb5d5a7592',
    messagingSenderId: '360679186391',
    projectId: 'mislab4',
    storageBucket: 'mislab4.firebasestorage.app',
    iosBundleId: 'com.example.lab4',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDPaD0X09gM2fXW0XsHbBAQgr206HatAHE',
    appId: '1:360679186391:web:1ab61154753b50895a7592',
    messagingSenderId: '360679186391',
    projectId: 'mislab4',
    authDomain: 'mislab4.firebaseapp.com',
    storageBucket: 'mislab4.firebasestorage.app',
  );
}