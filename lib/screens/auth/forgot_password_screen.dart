part of '../screens.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  static String routeName = '/forgot_password';
  final formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({
    super.key,
  });

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context, ref) {
    final isLocalLoading = useState<bool>(false);
    final colorScheme = Theme.of(context).colorScheme;
    final authProviderN = ref.read(authNotifierProvider.notifier);
    return Scaffold(
        appBar: AppBarWithBackIcon(
          showIconApp: true,
          centerTitle: true,
          /* title: 'Recuperar contraseña', */
          appBar: AppBar(),
        ),
        body: SizedBox.expand(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              /* crossAxisAlignment: CrossAxisAlignment.start, */
              children: [
                Icon(
                  Ionicons.mail_open_outline,
                  size: 150,
                  color: colorScheme.secondary,
                ),
                const SimpleText(
                  'Recuperación de contraseña',
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  /* lightThemeColor: Colors.black87, */
                ),
                const SimpleText(
                  'Vamos a enviar un correo electronico para recuperar su contraseña, por favor siga los pasos.',
                  padding: EdgeInsets.symmetric(vertical: 15),
                  fontSize: 15,
                  textAlign: TextAlign.center,
                ),
                FormBuilder(
                  enabled: !isLocalLoading.value,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CustomFormBuilderTextField(
                            name: 'email',
                            icon: FontAwesomeIcons.at,
                            placeholder: 'Email',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          LoginButton(
                            isLoading: isLocalLoading.value,
                            text: "Enviar email de recuperación",
                            textColor: Colors.white,
                            showIcon: false,
                            onPressed: () async {
                              final validationSuccess =
                                  _formKey.currentState!.validate();

                              if (!validationSuccess) return;

                              _formKey.currentState!.save();

                              isLocalLoading.value = true;
                              authProviderN.forgotPasswordRequest(
                                {
                                  'email':
                                      _formKey.currentState!.value['email'],
                                },
                              ).then((value) {
                                isLocalLoading.value = false;
                                /* TODO show some snackbar or something */
                                /* if (value) {
                                context.push('/home_screen');
                              } else {
                                isLocalLoading.value = false;
                              } */
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
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
