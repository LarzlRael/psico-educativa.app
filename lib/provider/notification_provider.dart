import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psico_educativa_app/constants/key_constants.dart';
import 'package:psico_educativa_app/services/services.dart';
import 'package:psico_educativa_app/config/local_notifications.dart';

class PushNotificationInit {
  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    /* await requestPermission(); */
  }

  // Apple / Web
  /* static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,2
        criticalAlert: false,
        provisional: false,
        sound: true);

    print('User push notification status ${settings.authorizationStatus}');
} */
}


final notificationNotifierProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>(
  (ref) => NotificationNotifier(),
);

class NotificationNotifier extends StateNotifier<NotificationState> {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  NotificationNotifier()
      : super(NotificationState(message: '', tokenDevice: '')) {
    _getAndSaveFCMToken();
    _onForegroundMessage();
  }

  void setNotification(String message) {
    state = state.copyWith(message: message);
  }

  void clearNotification() {
    state = state.copyWith(message: '');
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late String? token;
  Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    /* await requestPermission(); */

    token = (await messaging.getToken());

    print('Token: $token');

    state = state.copyWith(tokenDevice: token!);
    // Handlers
    /* FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp); */

    // Local Notifications
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
    state = state.copyWith(tokenDevice: token!);

    await keyValueStorageService.setKeyValue<String>(FCM_TOKEN, token!);
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    /* print('onMessage: ${message.notification.}'); */

    /* final notification = PushMessage(
      messageId: clearMessageId(message.messageId),
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );
    LocalNotification.showLocalNotification(
      id: notification.messageId.hashCode,
      body: notification.body,
      data: notification.messageId,
      title: notification.title,
    );
    add(NotificationsReceived(notification)); */
    LocalNotification.showLocalNotification(
      id: message.messageId.hashCode,
      title: message.notification!.title ?? '',
      body: message.notification!.body?? '',
      data: null,
    );
  }
}

class NotificationState {
  final String message;
  final String tokenDevice;
  NotificationState({
    required this.message,
    required this.tokenDevice,
  });

  NotificationState copyWith({
    String? message,
    String? tokenDevice,
  }) {
    return NotificationState(
      message: message ?? this.message,
      tokenDevice: tokenDevice ?? this.tokenDevice,
    );
  }
}
