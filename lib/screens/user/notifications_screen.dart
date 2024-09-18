part of '../screens.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});
  static const routeName = "/notifications";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final notificationsProvider = ref.read(notificationNotifierProvider);
    final notificationsState = ref.watch(notificationNotifierProvider);
    return ScaffoldWithBackground(
      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            Container(
              child: Row(
                /* mainAxisAlignment: MainAxisAlignment.spaceBetween, */
                children: [
                  /* Container(
                    margin: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        /* notificationsProvider.getNotifications(); */
                      },
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 25),
                    ),
                  ), */
                  SizedBox(width: 15),
                  const SimpleText('Notificaciones',
                      fontSize: 20, fontWeight: FontWeight.bold),
                ],
              ),
            ),
            notificationsState.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: notificationsState.notifications.length,
                      itemBuilder: (context, index) {
                        final notification =
                            notificationsState.notifications[index];

                        return _ListTileNotification(
                          notification,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _ListTileNotification extends StatelessWidget {
  const _ListTileNotification(
    this.notification, {
    super.key,
  });

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: () {
        if (notification.data?.idCourse == null) return;
        context.push(
          "${CourseEnrollmentScreen.routeName}/${notification.data?.idCourse}",
        );
      },
      leading: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          shape: BoxShape.circle,
        ),
      ),
      trailing: notification.imageUrl == null
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage.assetNetwork(
                placeholder: appIcon,
                image: notification.imageUrl!,
                width: 50,
                height: 50,
              ),
            ),
      title: SimpleText(
        notification.title.toCapitalize(),
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      subtitle: SimpleText(
        notification.body.toCapitalize(),
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
