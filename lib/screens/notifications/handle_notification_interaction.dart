part of '../screens.dart';

Future<void> requestPermissionLocalNotification() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}

class HandleNotificationInteractions extends ConsumerStatefulWidget {
  const HandleNotificationInteractions({super.key, required this.child});
  final Widget child;

  @override
  HandleNotificationInteractionsState createState() =>
      HandleNotificationInteractionsState();
}

class HandleNotificationInteractionsState
    extends ConsumerState<HandleNotificationInteractions> {
  Future<void> setupInteractedMessage() async {
    // Obtener cualquier mensaje que causó que la aplicación se abriera desde un estado terminado.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // Si el mensaje también contiene una propiedad de datos con un "type" de "chat",
    // navegar a una pantalla de chat
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // También manejar cualquier interacción cuando la aplicación está en segundo plano a través de un listener de Stream
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    ref
        .read(notificationNotifierProvider.notifier)
        .handleRemoteMessage(message);

    final notification = oneNotificationFromJson(message.data['information']);
    print('handlemessage!!!!!!!!!');
    /* goNotificationDestinyPage(context, notification); */
    final appRouter = ref.watch(goRouterProvider);

    inspect(notification);
    goNotificationDestinyPage(appRouter, notification.data);
    /* appRouter.push(
        '${NewCoursePromo.routeName}/${notification.data!.idCourse}'); */
  }

  @override
  void initState() {
    super.initState();
    // Ejecutar la configuración de mensajes interactuados
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return widget.child;
      },
    );
  }
}

