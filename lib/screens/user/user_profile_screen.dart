part of '../screens.dart';

const size = 15.0;
const colorIcon = Colors.grey;

class UserProfileScreen extends HookConsumerWidget {
  const UserProfileScreen({super.key});
  static const routeName = "/user-profile";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final authProviderN = ref.read(authNotifierProvider.notifier);
    final authProviderS = ref.watch(authNotifierProvider);
    final isLocalLoading = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    return ScaffoldWithBackground(
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Perfil de usuario'),
      ), */

      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            ProfileImageEdit(
              user: authProviderS.user!,
            ),
            SimpleText(
              authProviderS.user!.username.toCapitalize(),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.secondary,
              padding: const EdgeInsets.only(top: 10, bottom: 5),
            ),
            if (authProviderS.user!.email != null)
              SimpleText(authProviderS.user!.email, fontSize: 16),
            if (authProviderS.user!.firstName != null)
              SimpleText(
                  fontSize: 16,
                  '${authProviderS.user!.firstName!} ${authProviderS.user!.lastName!}'
                      .toCapitalizeEachWord()),
            FormBuilder(
              enabled: !isLocalLoading.value,
              key: formKey,
              child: Column(
                children: [
                  CustomFormBuilderTextField(
                    name: 'firstname',
                    trailingIcon: const Icon(
                      FontAwesomeIcons.lock,
                      color: colorIcon,
                      size: size,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    placeholder: 'Nombre/s',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  /* dont user const, BUG 🐛 */
                  const CustomFormBuilderTextField(
                    name: 'lastname',
                    trailingIcon: Icon(
                      FontAwesomeIcons.lock,
                      color: colorIcon,
                      size: size,
                    ),
                    placeholder: 'Apellido/s',
                  ),
                  const CustomFormBuilderTextField(
                    name: 'Telefono',
                    trailingIcon: Icon(
                      FontAwesomeIcons.phone,
                      color: colorIcon,
                      size: size,
                    ),
                    placeholder: 'Telefono',
                  ),
                  const CustomFormBuilderTextField(
                    name: 'location',
                    trailingIcon: Icon(
                      FontAwesomeIcons.locationDot,
                      color: colorIcon,
                      size: size,
                    ),
                    placeholder: 'Direccion',
                  ),
                  const CustomFormBuilderTextField(
                    name: 'shippingAddress',
                    trailingIcon: Icon(
                      FontAwesomeIcons.locationArrow,
                      color: colorIcon,
                      size: size,
                    ),
                    placeholder: 'Direccion de envio',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
