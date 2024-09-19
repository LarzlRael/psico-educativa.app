part of '../screens.dart';

const size = 18.0;
const colorIcon = Colors.grey;

class UserProfileScreen extends HookConsumerWidget {
  const UserProfileScreen({super.key});
  static const routeName = "/user-profile";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final authProviderN = ref.read(authNotifierProvider.notifier);
    final authProviderS = ref.watch(authNotifierProvider);

    return ScaffoldWithBackground(
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Perfil de usuario'),
      ), */

      child: Container(
        margin: const EdgeInsets.only(
          top: kToolbarHeight,
          right: 10,
          left: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*  Align(
                alignment: Alignment.topRight,
                child: Row(
                  /* mainAxisAlignment: MainAxisAlignment.end, */
                  children: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.powerOff),
                      onPressed: () async {
                        await showCustomConfirmDialog(
                          context,
                          title: 'Cerrar sesión',
                          content:
                              '¿Estás seguro de que quieres cerrar sesión?',
                          acceptText: 'Ok',
                          onAccept: () {
                            authProviderN.logout().then((value) {
                              if (value) {
                                context.go(SignInScreen.routeName);
                              }
                            });
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.penToSquare),
                      onPressed: () => isEnableForm.value = !isEnableForm.value,
                    ),
                    if (isEnableForm.value)
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.circleCheck,
                            color: Colors.green),
                        onPressed: onSubmit,
                      ),
                  ],
                ),
              ), */
              UserAvatar(
                radius: 55,
                username: authProviderS.user!.username,
                firstName: authProviderS.user!.firstName,
                lastName: authProviderS.user!.lastName,
                customWidget: isValidateString(
                        authProviderS.user!.profileImageUrl)
                    ? FadeInImage(
                        placeholder: const AssetImage(appIcon),
                        image:
                            NetworkImage(authProviderS.user!.profileImageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              SimpleText(
                authProviderS.user!.username.toCapitalize(),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
                padding: const EdgeInsets.only(top: 10, bottom: 5),
              ),
              if (authProviderS.user!.email != null)
                SimpleText(authProviderS.user!.email, fontSize: 14),
              if (authProviderS.user!.firstName != null)
                SimpleText(
                    fontSize: 14,
                    '${authProviderS.user!.firstName!} ${authProviderS.user!.lastName!}'
                        .toTitleCase()),
              const SizedBox(height: 10),
              const MenuProfileOption(
                title: "Cursos",
                leadingWidget: const Icon(FontAwesomeIcons.book),
              ),
              const MenuProfileOption(
                title: "Certificados",
                leadingWidget: Icon(FontAwesomeIcons.certificate),
              ),
              MenuProfileOption(
                leadingWidget: Icon(Icons.person),
                title: "Perfil",
                onTap: () =>
                    context.push(UserUpdateProfileInfoScreen.routeName),
              ),
              const MenuProfileOption(
                leadingWidget: Icon(Icons.settings),
                title: "Configuraciones",
              ),
              MenuProfileOption(
                trailingWidget: const SizedBox(),
                textColor: Colors.red,
                leadingWidget: Icon(Icons.logout, color: Colors.red),
                title: "Cerrar sesión",
                onTap: () async {
                  await showCustomConfirmDialog(
                    context,
                    title: 'Cerrar sesión',
                    content: '¿Estás seguro de que quieres cerrar sesión?',
                    acceptText: 'Ok',
                    onAccept: () {
                      authProviderN.logout().then((value) {
                        if (value) {
                          context.go(SignInScreen.routeName);
                        }
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic> formKeyToMap(GlobalKey<FormBuilderState> formKey) {
  return {
    for (var key in formKey.currentState!.fields.keys)
      key: formKey.currentState!.fields[key]!.value,
  };
}
