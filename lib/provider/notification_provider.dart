import 'dart:convert';
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psico_educativa_app/constants/key_constants.dart';
import 'package:psico_educativa_app/firebase_options.dart';
import 'package:psico_educativa_app/models/models.dart';
import 'package:psico_educativa_app/provider/auth_provider.dart';
import 'package:psico_educativa_app/provider/loca_notification_provider.dart';
import 'package:psico_educativa_app/services/notification_services.dart';
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/config/local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("ricibiste una notification push madafa: ${message.messageId}");
  final convertData = oneNotificationFromJson(message.data['information']);
  inspect(convertData);
  /* goNotificationDestinyPage() */
}

final notificationNotifierProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>(
  (ref) => NotificationNotifier(ref),
);

class NotificationNotifier extends StateNotifier<NotificationState> {
  final Ref ref; // Añade `Ref`
  final keyValueStorageService = KeyValueStorageServiceImpl();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  NotificationNotifier(this.ref)
      : super(NotificationState(
            message: '',
            tokenDevice: '',
            notifications: [],
            isLoading: false)) {
    _onForegroundMessage();
    getNotification();
    _getAndSaveFCMToken();

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.authenticateStatus == AuthStatus.authenticated) {
        _getAndSaveFCMToken();
      }
    });
  }

  void getNotification() async {
    state = state.copyWith(isLoading: true);
    final notifications = await getNotificationService();

    state = state.copyWith(isLoading: false, notifications: notifications);
  }

  void setNotification(String message) {
    state = state.copyWith(message: message);
  }

  void clearNotification() {
    state = state.copyWith(message: '');
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late String? token;

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void addNewNotification(NotificationModel notificationModel) {
    state = state
        .copyWith(notifications: [notificationModel, ...state.notifications]);
  }

  void initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
  }

  void _getAndSaveFCMToken() async {
    token = (await messaging.getToken())!;
    if (token == await keyValueStorageService.getValue<String>(FCM_TOKEN)) {
      return;
    }
    print('FCM Token: $token');

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final data = {
      'fcmToken': token,
      'deviceName': androidInfo.model,
    };

    final resp = await Request.sendAuthRequest(
        RequestType.post, 'devices/new-device',
        body: data);

    state = state.copyWith(tokenDevice: token!);

    await keyValueStorageService.setKeyValue<String>(FCM_TOKEN, token!);
  }

  void _onForegroundMessage() {
    print('FOREGROUND IS OK');
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

/* convert notification */

/* Convert payload data */

    final notificationConverted =
        oneNotificationFromJson(message.data['information']);

    addNewNotification(notificationConverted);
    ref.read(localNotificationProvider.notifier).showLocalNotification(
          id: notificationConverted.id,
          title: notificationConverted.title,
          body: notificationConverted.body,
          notificationImage: notificationConverted.imageUrl.toString(),
          payload: jsonEncode(notificationConverted.data),
        );
    /*   LocalNotification.showLocalNotification(
      id: notificationConverted.id,
      title: notificationConverted.title,
      body: notificationConverted.body,
      notificationImage: notificationConverted.imageUrl.toString(),
      payload: jsonEncode(notificationConverted.data)
    ); */
  }
}

class NotificationState {
  final String message;
  final String tokenDevice;
  final List<NotificationModel> notifications; // Array de notificaciones
  final bool isLoading; // Estado de carga

  NotificationState({
    required this.message,
    required this.tokenDevice,
    required this.notifications,
    required this.isLoading,
  });

  NotificationState copyWith({
    String? message,
    String? tokenDevice,
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) {
    return NotificationState(
      message: message ?? this.message,
      tokenDevice: tokenDevice ?? this.tokenDevice,
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
