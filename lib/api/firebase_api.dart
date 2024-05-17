import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // Initialize Firebase once
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Initialize Firebase Messaging for notifications
  static Future<void> initNotifications() async {
    // Request permission for receiving notifications
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Handle notification when the app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
