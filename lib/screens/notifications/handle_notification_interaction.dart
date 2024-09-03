part of '../screens.dart';


class HandleNotificationInteraction extends HookWidget {
  final Widget child;
  const HandleNotificationInteraction({
    super.key,
    required this.child,
  });

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    /* if (initialMessage != null) {
      _handleMessage(initialMessage);
    } */
  }

  /* void _handleMessage(RemoteMessage message) {
    final context = useContext();
    context.read<NotificationProvider>().handleRemoteMessage(message);

    final notification =
        notificationModelFromJson(message.data['data_from_server']);

    goNotificationDestinyPage(context, notification);
  } */

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      setupInteractedMessage();
      return null;
    }, const []);
    return child;
  }
}

/* void goNotificationDestinyPage(
  BuildContext context,
  NotificationModel notification,
) {
  switch (notification.type) {
    case 'new_comment':
      context.push('/homework_detail/${notification.idHomework}');
      break;
    case 'new_offer':
      context.push('/auction_with_offerPage/${notification.idHomework}');
      break;
    case 'homework_finished':
      context.push('/my_homeworks_page', extra: 1);
      break;
    case 'offer_accepted':
      context.push('/pending_homeworks_offers_accepts');
      break;
    default:
  }
} */