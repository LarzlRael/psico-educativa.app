part of '../screens.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  static String routeName = '/forgot_password';
  final formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isLocalLoading = useState<bool>(false);
    final colorScheme = Theme.of(context).colorScheme;
    final authProviderN = ref.read(authNotifierProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onPressed: context.pop,
          ),
          backgroundColor: Color(0xff2e7c78),
          title: const SimpleText(
            'Olvide mi contraseña',
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Color(0xff2e7c78),
        body: SizedBox.expand(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Ionicons.mail_open_outline,
                    size: 150,
                    color: colorScheme.secondary,
                  ),
                  const SimpleText('Recuperación de contraseña',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  const SimpleText(
                    'Por favor ingrese su correo electronico. Recibiras un enlace para crear una nueva contraseña',
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  FormBuilder(
                    enabled: !isLocalLoading.value,
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomFormBuilderTextField(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          borderRadius: 50,
                          fieldName: 'email',
                          leadingIcon: FontAwesomeIcons.at,
                          keyboardType: TextInputType.emailAddress,
                          placeholder: 'Correo electronico',
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ],
                          ),
                        ),
                        LoginButton(
                          isLoading: isLocalLoading.value,
                          backgroundColor: colorScheme.primary,
                          child: SimpleText(
                            "Enviar",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          borderRadius: 50,
                          /* textColor: Colors.white, */

                          onPressed: () async {
                            final validationSuccess =
                                formKey.currentState!.validate();

                            if (!validationSuccess) return;

                            formKey.currentState!.save();

                            isLocalLoading.value = true;
                            final resp =
                                await authProviderN.forgotPasswordRequest(
                              {
                                'email': formKey.currentState!.value['email'],
                              },
                            );
                            isLocalLoading.value = false;
                            if (resp) {
                              await KeyValueStorageServiceImpl()
                                  .setKeyValue<String>('email',
                                      formKey.currentState!.value['email']);
                              isLocalLoading.value = false;
                              if (!context.mounted) return;
                              context.push(VerificationCodeScreen.routeName);
                              /* TODO show some snackbar or something */
                              /* if (value) {
                                  context.push('/home_screen');
                                } else {
                                  isLocalLoading.value = false;
                                } */
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        )));
  }

  /* void _submit() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    /* print(this.emailField); */
    final resp = await mailServices.requestPasswordChange(emailField);
    if (resp) {
      GlobalSnackBar.show(
          context, 'Correo enviado, revise su bandeja de entrada',
          backgroundColor: Colors.green);
      Navigator.pop(context);
    } else {
      GlobalSnackBar.show(context, 'Hubo un error al comprobar su email',
          backgroundColor: Colors.red);
    }
  } */
}
