import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:psico_educativa_app/config/environment.dart';
import 'package:psico_educativa_app/provider/notification_provider.dart';
import 'package:psico_educativa_app/router/app_router.dart';
import 'package:psico_educativa_app/screens/screens.dart';
import 'firebase_options.dart';

/* void main() => runApp(const MyApp()); */
void main() async {
  await Environment.initEnvironment();

  /* await UserPreferences.init(); */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /* await FirebaseUtils().initializeRemoteConfig(); */
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
      builder: (context, child) => HandleNotificationInteraction(
          child: child!,
        ),
    );
  }
}
