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

    final mapState = ref.watch(mapFinderNotifierProvider);

    final isLocalLoading = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isEnable = useState(true);
    final userState = authProviderS.user;
    final initialValues = {
      'firstName': userState?.firstName ?? '',
      'lastName': userState?.lastName ?? '',
      'phone': userState?.phone ?? '',
      'location': userState?.location ?? '',
      'shippingAddress': userState?.shippingAddress ?? '',
      'addressCoordinates': {
        'latitude': userState?.addressCoordinates?.latitude ?? '',
        'longitude': userState?.addressCoordinates?.latitude ?? '',
      }
    };

    onSubmit() async {
      final validationSuccess = formKey.currentState?.validate() ?? false;

      if (!validationSuccess) return;

      formKey.currentState?.save();

      isLocalLoading.value = true;
      final data = formKeyToMap(formKey);
      final addLatLng = {
        ...data,
        'addressCoordinates': {
          'latitude': mapState!.candidateSelectedPosition!.geometry.location.lat
              .toString(),
          'longitude': mapState.candidateSelectedPosition!.geometry.location.lng
              .toString(),
        },
        'shippingAddress': mapState.candidateSelectedPosition!.formattedAddress,
      };

      isLocalLoading.value = true;
      authProviderN.updateProfileInfo(addLatLng).then((value) {
        isLocalLoading.value = false;
        if (value) {
          toastification.show(
            title: Text('Perfil actualizado'),
            backgroundColor: Colors.green,
            alignment: Alignment.bottomCenter,
            autoCloseDuration: const Duration(seconds: 5),
          );
          return;
        }
        toastification.show(
          type: ToastificationType.error,
          title: Text('Error al actualizar el perfil'),
          backgroundColor: Colors.red,
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 5),
        );
      });
      
    }

    return ScaffoldWithBackground(
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Perfil de usuario'),
      ), */

      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.penToSquare),
                      onPressed: () => isEnable.value = !isEnable.value,
                    ),
                    if (isEnable.value)
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.circleCheck,
                            color: Colors.green),
                        onPressed: onSubmit,
                      ),
                  ],
                ),
              ),
              ProfileImageEdit(
                onImageSelected: (filePath) async {
                  final resp = await authProviderN.updateProfileImage(filePath);
                },
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
                initialValue: initialValues,
                enabled: isEnable.value && !isLocalLoading.value,
                key: formKey,
                child: Column(
                  children: [
                    CustomFormBuilderTextField(
                      fieldName: 'firstName',
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
                    CustomFormBuilderTextField(
                      fieldName: 'lastName',
                      trailingIcon: Icon(
                        FontAwesomeIcons.lock,
                        color: colorIcon,
                        size: size,
                      ),
                      placeholder: 'Apellido/s',
                    ),
                    CustomFormBuilderTextField(
                      fieldName: 'phone',
                      trailingIcon: Icon(
                        FontAwesomeIcons.phone,
                        color: colorIcon,
                        size: size,
                      ),
                      placeholder: 'Telefono',
                      keyboardType: TextInputType.phone,
                    ),
                    CustomFormBuilderTextField(
                      fieldName: 'location',
                      trailingIcon: Icon(
                        FontAwesomeIcons.locationDot,
                        color: colorIcon,
                        size: size,
                      ),
                      placeholder: 'Direccion',
                    ),
                    CustomFormBuilderTextField(
                      fieldName: 'shippingAddress',
                      trailingIcon: IconButton(
                        onPressed: () {
                          context.push(MapFindLocationScreen.routeName);
                        },
                        icon: Icon(
                          FontAwesomeIcons.locationArrow,
                          color: colorIcon,
                          size: size,
                        ),
                      ),
                      placeholder: 'Direccion de envio',
                    ),
                    /* FilledButton(
                      /* isLoading: isLocalLoading.value, */
                      child: Text("Guardar"),
                      /* textColor: Colors.white, */
                      onPressed: () async {
                        await onSubmit();
                      },
                    ), */
                  ],
                ),
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
