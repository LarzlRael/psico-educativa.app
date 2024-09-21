// ignore_for_file: prefer_const_constructors

part of '../screens.dart';

class UserUpdateProfileInfoScreen extends HookConsumerWidget {
  const UserUpdateProfileInfoScreen({super.key});
  static const routeName = "/user_update_profile_info_screen";
  @override
  Widget build(BuildContext context, ref) {
    final userState = ref.watch(authNotifierProvider).user;
    final authProviderN = ref.read(authNotifierProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    final isLocalLoading = useState(false);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    final mapState = ref.watch(mapFinderNotifierProvider);

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
          'latitude': mapState.candidateSelectedPosition!.geometry.location.lng
              .toString(),
          'longitude': mapState.candidateSelectedPosition!.geometry.location.lng
              .toString(),
        },
        'shippingAddress': mapState.candidateSelectedPosition!.formattedAddress,
      };

      isLocalLoading.value = true;
      showLoadingDialog(context, message: 'Actualizando perfil...');
      authProviderN.updateProfileInfo(addLatLng).then((value) {
        isLocalLoading.value = false;

        /* TODO add isMounted condition */
        context.pop();
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
      child: SizedBox.expand(
        child: Container(
          margin: EdgeInsets.only(
              left: 15, right: 15, top: MediaQuery.of(context).padding.top),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  /* mainAxisAlignment: MainAxisAlignment.end, */
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: colorScheme.secondary,
                      child: IconButton(
                        icon: const Icon(FontAwesomeIcons.chevronLeft),
                        onPressed: context.pop,
                      ),
                    ),
                    SizedBox(width: 10),
                    SimpleText(
                      'Perfil',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    /* IconButton(
                      icon: Icon(isEnableForm.value
                          ? FontAwesomeIcons.circleXmark
                          : FontAwesomeIcons.penToSquare),
                      onPressed: () => isEnableForm.value = !isEnableForm.value,
                    ),
                    if (isEnableForm.value)
                      TextButton.icon(
                        label: const SimpleText('Guardar',
                            fontSize: 14, color: Colors.green),
                        icon: const Icon(FontAwesomeIcons.circleCheck,
                            color: Colors.green),
                        onPressed: null,
                      ), */
                  ],
                ),
                ProfileImageEdit(
                  radius: 50,
                  iconCameraSize: 20,
                  onImageSelected: (filePath) async {
                    final resp =
                        await authProviderN.updateProfileImage(filePath);
                  },
                  user: userState!,
                ),
                FormBuilder(
                  initialValue: initialValues,
                  enabled: !isLocalLoading.value,
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormBuilderTextField(
                        label: 'Nombre/s',
                        fieldName: 'firstName',
                        trailingIcon: const Icon(
                          FontAwesomeIcons.user,
                          color: colorIcon,
                          size: size,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      /* dont user const, BUG 🐛 */
                      CustomFormBuilderTextField(
                        label: 'Apellido/s',
                        fieldName: 'lastName',
                        trailingIcon: Icon(
                          FontAwesomeIcons.userAstronaut,
                          color: colorIcon,
                          size: size,
                        ),
                      ),
                      CustomFormBuilderTextField(
                        fieldName: 'phone',
                        trailingIcon: Icon(
                          Icons.call_outlined,
                          color: colorIcon,
                          size: size,
                        ),
                        label: 'Telefono',
                        keyboardType: TextInputType.phone,
                      ),
                      CustomFormBuilderTextField(
                        fieldName: 'location',
                        trailingIcon: Icon(
                          FontAwesomeIcons.locationDot,
                          color: colorIcon,
                          size: size,
                        ),
                        label: 'Direccion',
                      ),
                      CustomFormBuilderTextField(
                        fieldName: 'shippingAddress',
                        trailingIcon: IconButton(
                          onPressed: () {
                            print('shippingAddress');
                            context.push(MapFindLocationScreen.routeName);
                          },
                          icon: Icon(
                            FontAwesomeIcons.locationPin,
                            color: Colors.blue,
                            size: size + 5,
                          ),
                        ),
                        label: 'Direccion de envio',
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        
                        child: LoginButton(
                          borderRadius: 50,
                          /* isLoading: isLocalLoading.value, */
                          backgroundColor: colorScheme.primary,
                          child: SimpleText(
                            "Actualizar Perfil",
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            /* await onSubmit(); */
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
