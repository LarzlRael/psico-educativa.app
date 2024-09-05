import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:psico_educativa_app/main.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/shared/utils.dart';

import '../screens/screens.dart';

class LocalNotification {
  static Future<void> requestPermissionLocalNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      /* TODO ios config settings */
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    String? notificationImage,
  }) async {
    print(payload);
    final String iconPath = notificationImage ??
        'https://res.cloudinary.com/druajlfie/image/upload/v1725496374/logo-psicoeducativa_clean_v6py19.png';

    final String largeIconPath =
        await downloadAndSaveFile(iconPath, 'largeIcon');
    final String bigPicturePath =
        await downloadAndSaveFile(iconPath, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      hideExpandedLargeIcon: false,

      /* contentTitle: 'overridden <b>big</b> content title',
            htmlFormatContentTitle: true,
            summaryText: 'summary <i>text</i>',
            htmlFormatSummaryText: true */
    );

    var androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,

      /* TODO IOS */
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    

    if (response.payload == null) return;
    final convertedData = oneDataFromJson(response.payload!);
    inspect(navigatorKey);
    navigatorKey.currentState!.context.pushNamed(
        '${HomeScreen.routeName}/${NewCoursePromo.routeName}/${convertedData.idCourse}');
  }
}
