part of '../screens.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";
  @override
  Widget build(BuildContext context, ref) {
    final authProviderN = ref.read(authNotifierProvider.notifier);
    final authProviderS = ref.watch(authNotifierProvider);

    /*
    final courserN = ref.read(courseNotifierProvider.notifier);
    final courserS = ref.watch(courseNotifierProvider); */

    /* useEffect(() {
      /* courseNotifierProviderN.getCourseDetails(idCourse).then((value) {}); */
      Future.microtask(() => courserN.getCourses());
    }, []); */
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: SizedBox.expand(
      child: BackgroundWithBlurredCircles(
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => context.push(UserProfileScreen.routeName),
                      child: Container(
                        height: 55,
                        /* width: 140, */

                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Wrap(
                          /* alignment: WrapAlignment.center, */
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            UserAvatar(
                              username: authProviderS.user!.username,
                              urlImage: authProviderS.user!.profileImageUrl,
                              firstName: authProviderS.user!.firstName,
                              lastName: authProviderS.user!.lastName,
                            ),
                            const SizedBox(width: 15),
                            SimpleText(authProviderS.user!.username,
                                fontSize: 18),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                        onPressed: () {
                          authProviderN.logout().then((value) {
                            if (value) {
                              if (!context.mounted) return;
                              context.go(SignInScreen.routeName);
                            }
                          });
                        },
                        icon: Icon(Ionicons.search),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SimpleText('Legal help, Your Way', fontSize: 18),
                const SizedBox(height: 10),
                SimpleText(
                  'Find Top class',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
                SimpleText('Lawyers',
                    fontSize: 35, fontWeight: FontWeight.bold),
              ]),
        )),
      ),
    ));
  }
}

Future<List<NotificationModel>> getNotification() async {
  final resp = await Request.sendRequest(
      RequestType.get, 'notifications/get-notification');
  return notificationsModelFromJson(resp!.body);
}
