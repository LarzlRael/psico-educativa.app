part of '../screens.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";
  @override
  Widget build(BuildContext context, ref) {
    final authProviderN = ref.watch(authNotifierProvider.notifier);
    final authProviderS = ref.read(authNotifierProvider);

    final notificationProviderS = ref.read(notificationNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello ${authProviderS.user?.username}'),
            Text('token ${authProviderS.user?.accessToken}'),
            FilledButton(
                onPressed: () async {
                  await authProviderN.logout();
                },
                child: Text('cerrar sesion',
                    style: TextStyle(color: Colors.black))),
           /*  notificationProviderS.isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                        itemCount: notificationProviderS.notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          final notification =
                              notificationProviderS.notifications[index];

                          return ListTile(
                            leading: notification.imageUrl == null
                                ? null
                                : Image.network(notification.imageUrl!),
                            title: Text(notification.title),
                            subtitle: Text(notification.body),
                          );
                        }),
                  ) */
          ],
        ),
      ),
    );
  }
}

Future<List<NotificationModel>> getNotification() async {
  final resp = await Request.sendRequest(
      RequestType.get, 'notifications/get-notification');
  return notificationsModelFromJson(resp!.body);
}
