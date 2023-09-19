import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:283466351178:ios:11f94d8546d09dc5939cb3',
        apiKey: 'AIzaSyDZMrO_9KcpEJc8yMiIL4oYEi9a5gFOzHI',
        projectId: 'e-commerce-6455a',
        messagingSenderId: '283466351178	',
        iosBundleId: 'com.example.youtubeEcommerce',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:401773797377:android:8495bbdd07af231ea7e000',
        apiKey: 'AIzaSyBGCt1ITDuTVxIj4jWrP8eE8XU95coHsgs',
        projectId: 'mysellcommerce',
        messagingSenderId: '401773797377',
      );
    }
  }
}
