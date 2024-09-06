import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:psico_educativa_app/main.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/router/app_router.dart';
import 'package:psico_educativa_app/shared/router_utils.dart';
import 'package:psico_educativa_app/shared/utils.dart';

import '../screens/screens.dart';

// Define un provider para las notificaciones locales
final localNotificationProvider =
    StateNotifierProvider<LocalNotificationNotifier, void>((ref) {
  return LocalNotificationNotifier(ref);
});

class LocalNotificationNotifier extends StateNotifier<void> {
  final Ref ref;

  LocalNotificationNotifier(this.ref) : super(null) {
    initializeLocalNotification();
  }

  Future<void> requestPermissionLocalNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> initializeLocalNotification() async {
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

  Future<void> showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    String? notificationImage,
  }) async {
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

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    if (response.payload == null) return;

    final convertedData = oneDataFromJson(response.payload!);

    // Accede al provider de navegación para realizar el push
    final appRouter = ref.watch(goRouterProvider);
    inspect(convertedData);
    print('Pushing!!!!');
    inspect(appRouter);
    goNotificationDestinyPage(appRouter, convertedData);
  }
}
