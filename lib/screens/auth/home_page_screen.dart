part of '../screens.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = "/home";
  HomeScreen({
    super.key,
  });
  final listScreen = [
    const HomeScreenItem(),
    const HomeScreenItem(),
    const NotificationsScreen(),
    const UserProfileScreen(),
  ];
  @override
  Widget build(BuildContext context, ref) {
    final selectedIndex =
        ref.watch(menuProvider); // Observamos el índice actual

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const BottomNavigationFLoating(
          /* currentIcon: viewModel.currentIndex,
            icons: viewModel.icons, */
          ),
      body: listScreen[selectedIndex],
    );
  }
}

class HomeScreenItem extends HookConsumerWidget {
  const HomeScreenItem({super.key});
  static const routeName = "/home_screen";
  @override
  Widget build(BuildContext context, ref) {
    final authProviderN = ref.read(authNotifierProvider.notifier);
    final authProviderS = ref.watch(authNotifierProvider);
    final courserS = ref.watch(courseNotifierProvider);
    /*
    final courserN = ref.read(courseNotifierProvider.notifier);
     */

    /* useEffect(() {
      /* courseNotifierProviderN.getCourseDetails(idCourse).then((value) {}); */
      Future.microtask(() => courserN.getCourses());
    }, []); */
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: ScaffoldWithBackground(
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
                      onTap: () =>
                          ref.read(menuProvider.notifier).selectItem(3),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Wrap(
                          /* alignment: WrapAlignment.center, */
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            UserAvatar(
                              username: authProviderS.user!.username,
                              firstName: authProviderS.user!.firstName,
                              lastName: authProviderS.user!.lastName,
                              customWidget: FadeInImage(
                                placeholder: const AssetImage(appIcon),
                                image: NetworkImage(
                                    authProviderS.user!.profileImageUrl!),
                              ),
                            ),
                            const SizedBox(width: 15),
                            SimpleText(
                                authProviderS.user!.username.toCapitalize(),
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
                courserS.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: MasonryGridView.count(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemCount: courserS.courses.length,
                          itemBuilder: (context, index) {
                            final course = courserS.courses[index];

                            return OneCourseCard(
                              course,
                              onSelected: (idCourse) {
                                context.push(
                                  '${NewCoursePromoScreen.routeName}/$idCourse',
                                );
                              },
                            );
                          },
                        ),
                      )
              ]),
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
