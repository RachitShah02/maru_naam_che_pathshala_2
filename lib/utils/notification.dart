import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:maru_naam_che_pathshala_2/screens/events/events_details.dart';
import 'package:maru_naam_che_pathshala_2/utils/notification_service.dart';

import 'utils.dart';

noti() {
  LocalNotificationService.initialize();

  ///gives you the message on which user taps
  ///and it opened the app from terminated state
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      final id = message.data["id"];
      Get.to(() => EventsDetailsScreen(id: id));
    }
  });

  ///forground work
  FirebaseMessaging.onMessage.listen((message) {
    if (Platform.isAndroid) {
      LocalNotificationService.display(message);
    }
  });

  ///When the app is in background but opened and user taps
  ///on the notification
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    final id = message.data["id"];
    Get.to(() => EventsDetailsScreen(id: id));
  });
}
