import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:park_waze/firebase_options.dart';

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessagin = FirebaseMessaging.instance;
  static String? token;

  static Future initializeApp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await _firebaseMessagin.requestPermission();
    token = await _firebaseMessagin.getToken();
    print('Token: $token');
  }
}
