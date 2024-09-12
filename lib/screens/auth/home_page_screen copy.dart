/* part of '../screens.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";
  @override
  Widget build(BuildContext context, ref) {
    final authProviderN = ref.watch(authNotifierProvider.notifier);
    final authProviderS = ref.read(authNotifierProvider);

    final courserN = ref.read(courseNotifierProvider.notifier);
    final courserS = ref.watch(courseNotifierProvider);

    useEffect(() {
      /* courseNotifierProviderN.getCourseDetails(idCourse).then((value) {}); */
      Future.microtask(() => courserN.getCourses());
    }, []);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await authProviderN.logout();
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello ${authProviderS.user?.username}'),
            Text('token ${authProviderS.user?.accessToken}'),
            FilledButton(
                onPressed: () =>
                    context.push('${NewCoursePromoScreen.routeName}/10'),
                child: Text(
                  'Ir a curso ',
                )),
            courserS.isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                        itemCount: courserS.courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final notification = courserS.courses[index];

                          return ListTile(
                            onTap: () {
                              context.push(
                                  '${NewCoursePromoScreen.routeName}/${notification.id}');
                            },
                            leading: notification.imageUrl == null
                                ? null
                                : Image.network(notification.imageUrl!),
                            title: Text(notification.courseName),
                            subtitle: Text(notification.requirements),
                          );
                        }),
                  )
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
 */