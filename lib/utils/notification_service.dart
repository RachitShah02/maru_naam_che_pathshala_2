import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:maru_naam_che_pathshala_2/screens/screens.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings());

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? data) async {
      if (data != null) {
        Map<String, dynamic> decodedData = json.decode(data);
        String id = decodedData['id'];
        Get.to(() => EventsDetailsScreen(id: id));
      }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final imageUrl =
          message.notification!.android?.imageUrl ?? ''; // Remote image URL
      // Fetch the remote image
      final http.Response response = await http.get(Uri.parse(imageUrl));
      NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("BIZYLOOK_MARU_NAAM_PATHSHALA",
              "MARU NAAM CHE PATHSHAL MAIN CHANNEL",
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              styleInformation: (response.statusCode == 200)
                  ? BigPictureStyleInformation(
                      ByteArrayAndroidBitmap.fromBase64String(
                          base64Encode(response.bodyBytes)),
                      contentTitle: message.notification!.title,
                      summaryText: message.notification!.body,
                    )
                  : const BigTextStyleInformation('')),
          iOS: IOSNotificationDetails(
              subtitle: message.notification!.body,
              presentAlert: true,
              presentBadge: true,
              presentSound: true));

      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: json.encode(message.data));
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
