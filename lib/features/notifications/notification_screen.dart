import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:roam/theme/pallete.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _setupPushNotifications();
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _setupPushNotifications() async {
    await _firebaseMessaging.requestPermission();
    _firebaseMessaging.subscribeToTopic('trips');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      // Update UI with the received message
      setState(() {
        _notificationMessage = message.notification?.body ?? '';
      });
    });
  }

  String _notificationMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: _notificationMessage.isEmpty
          ? const Center(
              child: Text(
                'No new messages.',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  color: Pallete.lightBlue,
                  elevation: 5.0,
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _notificationMessage,
                      style: const TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 15,
                        color: Pallete.lightGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
