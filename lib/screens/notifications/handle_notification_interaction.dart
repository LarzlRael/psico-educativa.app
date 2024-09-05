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
    goNotificationDestinyPage(context, notification);
    inspect(notification);
    
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

void goNotificationDestinyPage(
  BuildContext context,
  NotificationModel notification,
) {
  switch (notification.data?.pageDestination) {
    case 'new_course':
      context.push(
          '${HomeScreen.routeName}/${NewCoursePromo.routeName}/${notification.data?.idCourse}');
      break;
    /* case 'new_offer':
      context.push('/auction_with_offerPage/${notification.idHomework}');
      break;
    case 'homework_finished':
      context.push('/my_homeworks_page', extra: 1);
      break;
    case 'offer_accepted':
      context.push('/pending_homeworks_offers_accepts');
      break; */
    default:
  }
}
void goNotificationRoutePage(
  BuildContext context,
  NotificationModel notification,
) {
  switch (notification.data?.pageDestination) {
    case 'new_course':
      context.push(
          '${HomeScreen.routeName}/${NewCoursePromo.routeName}/${notification.data?.idCourse}');
      break;
    /* case 'new_offer':
      context.push('/auction_with_offerPage/${notification.idHomework}');
      break;
    case 'homework_finished':
      context.push('/my_homeworks_page', extra: 1);
      break;
    case 'offer_accepted':
      context.push('/pending_homeworks_offers_accepts');
      break; */
    default:
  }
}
