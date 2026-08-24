import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/firebase_options.dart';
import 'package:test_notification/core/notification_service.dart';
import 'package:test_notification/pages/on_board_page.dart';

final localNotifictionsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final notificationService = NotificationService();

  await notificationService.init();

  await initiliseLocalNotification();

  runApp(const MyApp());
}

Future<void> initiliseLocalNotification() async {
  
  const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const IOSInitializationSettings iosInitSettings = IOSInitializationSettings();
  const InitializationSettings initSettings = InitializationSettings(
    android: androidInitSettings,
    iOS: iosInitSettings,
  );
  
  await localNotifictionsPlugin.initialize(
    settings: initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap
      debugPrint('Notification payload: ${response.payload}');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: primaryColor)),
      debugShowCheckedModeBanner: false,
      home: const OnBoardPage(),
    );
  }
}

