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
    apiKey: 'AIzaSyCeCjphlGmZAcxtqW5zsSBVLZ3prnv7fwc',
    appId: '1:578169148556:web:cedfe8e8d51b6e1327d7a9',
    messagingSenderId: '578169148556',
    projectId: 'kredo-670fd',
    authDomain: 'kredo-670fd.firebaseapp.com',
    storageBucket: 'kredo-670fd.firebasestorage.app',
    measurementId: 'G-E22J025LMJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHuYYS3DIEpCBLXrC7tfiMlKl9FANxbdU',
    appId: '1:578169148556:android:d7429420c48bb30a27d7a9',
    messagingSenderId: '578169148556',
    projectId: 'kredo-670fd',
    storageBucket: 'kredo-670fd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPqkrnn5QQE6CUV60DvZU4Z79pBWMvdt8',
    appId: '1:578169148556:ios:bdf1d1e9b845e53627d7a9',
    messagingSenderId: '578169148556',
    projectId: 'kredo-670fd',
    storageBucket: 'kredo-670fd.firebasestorage.app',
    iosBundleId: 'com.example.kredo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPqkrnn5QQE6CUV60DvZU4Z79pBWMvdt8',
    appId: '1:578169148556:ios:bdf1d1e9b845e53627d7a9',
    messagingSenderId: '578169148556',
    projectId: 'kredo-670fd',
    storageBucket: 'kredo-670fd.firebasestorage.app',
    iosBundleId: 'com.example.kredo',
  );
}
