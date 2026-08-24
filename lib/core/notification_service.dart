import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class NotificationService {
  final _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    final settings = await _messaging.requestPermission();

    debugPrint('Permission: ${settings.authorizationStatus}');

    final fcmToken = await _messaging.getToken();

    debugPrint("FCMTokken $fcmToken");

    FirebaseMessaging.instance.onTokenRefresh
        .listen((newToken) {
          debugPrint('New FCM TOKEN: $newToken');
        })
        .onError((err) {
          debugPrint(err.toString());
        });
  }

  

}
