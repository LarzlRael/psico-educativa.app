import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psico_educativa_app/config/environment.dart';
import 'package:psico_educativa_app/config/local_notifications.dart';
import 'package:psico_educativa_app/provider/notification_provider.dart';
import 'package:psico_educativa_app/router/app_router.dart';
import 'package:psico_educativa_app/screens/screens.dart';
import 'package:psico_educativa_app/shared/theme.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationNotifier.initializeApp();
  await Environment.initEnvironment();

  /* await UserPreferences.init(); */
  
  /* await FirebaseUtils().initializeRemoteConfig(); */
  await LocalNotification.initializeLocalNotification();
  return runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationProvider = ref.watch(notificationNotifierProvider);
    final appRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'Material App',

      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(isDarkMode: false).getTheme(),
      builder: (context, child) => HandleNotificationInteractions(
        child: child!,
      ),
    );
  }
}
