import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_notification/firebase_options.dart';
import 'package:test_notification/notification_service.dart';

// final localNotifictionsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final notificationService = NotificationService();

  await notificationService.init();

  // await initiliseLocalNotification();

  runApp(const MyApp());
}

// Future<void> initiliseLocalNotification() async {
  
//   const AndroidInitializationSettings androidInitSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   const IOSInitializationSettings iosInitSettings = IOSInitializationSettings();
//   const InitializationSettings initSettings = InitializationSettings(
//     android: androidInitSettings,
//     iOS: iosInitSettings,
//   );
  
//   await localNotifictionsPlugin.initialize(
//     settings: initSettings,
//     onDidReceiveNotificationResponse: (NotificationResponse response) {
//       // Handle notification tap
//       debugPrint('Notification payload: ${response.payload}');
//     },
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepOrange)),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  Future setupInteractedMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    // FirebaseMessaging.onMessage.listen(_showForegroundNotification);
  }

  // Future<void> _showForegroundNotification(RemoteMessage message) async {
  //   final data = message.data;

  //   await localNotifictionsPlugin.show(
  //     id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  //     title: data['title'] ?? message.notification?.title ?? 'Notification',
  //     body: data['body'] ?? message.notification?.body,
  //     notificationDetails: NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channel_1',
  //         'Channel 1',
  //         importance: Importance.high,
  //         priority: Priority.high,
  //       ),
  //       iOS: const DarwinNotificationDetails(
  //         presentAlert: true,
  //         presentSound: true,
  //       ),
  //     ),

  //   );
  // }

  void _handleMessage(RemoteMessage message) {
    print(message.data);
    if (message.data.containsKey('counter')) {
      setState(() {
        _counter = int.parse(message.data['counter']);
      });
    }
    debugPrint(_counter.toString());
  }

  @override
  void initState() {
    super.initState();
    // _initializeLocalNotifications();
    setupInteractedMessage();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
