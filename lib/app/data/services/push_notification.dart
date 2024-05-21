import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:park_waze/firebase_options.dart';

class PushNotificationService {
  static FirebaseMessaging? _firebaseMessaging;
  static String? token;

  static Future initializeApp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    if (!kIsWeb) {
      _firebaseMessaging = FirebaseMessaging.instance;
      await _firebaseMessaging!.requestPermission();
      token = await _firebaseMessaging!.getToken();
      print('Token: $token');
    } else {
      print('Push notifications are not supported on the web.');
    }
  }
}
