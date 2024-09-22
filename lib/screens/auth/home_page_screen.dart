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
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SimpleText(
                      'Hello,\n ${authProviderS.user!.username.toCapitalize()}',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    SquareAvatar(
                      size: 60,
                      user: authProviderS.user,
                      onTap: () =>
                          ref.read(menuProvider.notifier).selectItem(3),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: colorScheme.secondary, size: 30),
                        SizedBox(width: 10),
                        SimpleText(
                          'Search for courses',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                ),
                courserS.isLoading
                    ? Expanded(
                        child: MasonryGridView.count(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemCount: 6,
                          itemBuilder: (_, __) => const OneCourseCardShimmer(),
                        ),
                      )
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
                                  '${CourseEnrollmentScreen.routeName}/$idCourse',
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

class UserNameAvatar extends StatelessWidget {
  const UserNameAvatar({
    super.key,
    required this.user,
    required this.onTap,
  });

  final UserApi? user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.4),
            borderRadius: BorderRadius.circular(30)),
        child: Wrap(
          /* alignment: WrapAlignment.center, */
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            UserAvatar(
              username: user!.username,
              firstName: user!.firstName,
              lastName: user!.lastName,
              customWidget: !isValidateString(user!.profileImageUrl)
                  ? null
                  : FadeInImage(
                      placeholder: const AssetImage(appIcon),
                      image: NetworkImage(user!.profileImageUrl!),
                    ),
            ),
            const SizedBox(width: 15),
            SimpleText(user!.username.toCapitalize(), fontSize: 18),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class SquareAvatar extends StatelessWidget {
  const SquareAvatar({
    super.key,
    required this.user,
    required this.onTap,
    this.size = 40,
  });

  final UserApi? user;
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        /* padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), */
        decoration: BoxDecoration(
          color: 
          user!.profileImageUrl == null
              ? colorScheme.secondary.withOpacity(0.4)
              :
          null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: isValidateString(user!.profileImageUrl)
              ? FadeInImage(
                  placeholder: const AssetImage(appIcon),
                  image: NetworkImage(user!.profileImageUrl!),
                  width: size,
                  height: size,
                )
              : SimpleText(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  avatarLabel(
                    user!.username,
                    user!.firstName,
                    user!.lastName,
                  ),
                ),
        ),
      ),
    );
  }
}
