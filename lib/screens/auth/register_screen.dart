part of '../screens.dart';

class RegisterScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  static String routeName = '/register';
  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* final authService = Provider.of<AuthServices>(context); */
    final authServiceNotifier = ref.read(authNotifierProvider.notifier);
    final isLocalLoading = useState<bool>(false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            /* height: MediaQuery.of(context).size.height, */
            padding: const EdgeInsets.only(
              bottom: 30,
              top: 20,
              left: 30.0,
              right: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const HeaderLoginRegister(
                      headerTitle: 'Registro',
                    ),
                    FormBuilder(
                        key: _formKey,
                        child: const Column(
                          children: [
                            const CustomFormBuilderTextField(
                              name: 'username',
                              icon: Icons.person,
                              placeholder: 'Nombre de usuario',
                            ),
                            const CustomFormBuilderTextField(
                              name: 'email',
                              keyboardType: TextInputType.emailAddress,
                              icon: FontAwesomeIcons.at,
                              placeholder: 'Correo electrónico',
                            ),
                            const CustomFormBuilderTextField(
                              name: 'password',
                              icon: FontAwesomeIcons.lock,
                              placeholder: 'Contraseña',
                              passwordField: true,
                            ),
                            const CustomFormBuilderTextField(
                              name: 'password',
                              icon: FontAwesomeIcons.lock,
                              placeholder: 'Repetir contraseña',
                              passwordField: true,
                            ),
                            /* FormBuilderCheckbox(
                              name: 'accept_terms',
                              initialValue: false,
                              title: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Tengo más de 18 años',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              validator: FormBuilderValidators.equal(
                                true,
                                errorText:
                                    'Debes marcar la casilla de confirmación para continuar',
                              ),
                            ), */
                          ],
                        ))
                  ],
                ),
                Column(
                  children: [
                    LoginButton(
                      text: "Regitrarse",
                      showIcon: false,
                      textColor: Colors.white,
                      /* borderRadius: 50, */
                      onPressed: () {
                        final validationSuccess =
                            _formKey.currentState!.validate();
                        if (!validationSuccess) return;

                        /* Validated form */

                        _formKey.currentState!.save();
                        isLocalLoading.value = true;
                        /* TODO create a object */
                        authServiceNotifier.register({
                          'username': _formKey.currentState!.value['username'].trim(),
                          'email': _formKey.currentState!.value['email'].trim(),
                          'password': _formKey.currentState!.value['password'].trim(),
                        }).then((value) {
                          isLocalLoading.value = false;
                        });

                        /* if (login) {
                            Navigator.pushReplacementNamed(context, 'login');
                          } else {
                            showSimpleAlert(
                                context, 'hubo un error en el registro');
                          } */
                      },
                    ),
                    LoginButton(
                      spacing: 20,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      onPressed: () {
                        /* authProviderN.loginWithGoogle().then((value) {
                            isLocalLoading.value = false;
                          }); */
                      },
                      text: "Registrarse con google",
                      backGroundColor: Colors.white,
                      icon: Image.asset(
                        'assets/icons/google_icon.png',
                        width: 30,
                        height: 30,
                      ),
                      textColor: Colors.black87,
                    ),
                    LabelLoginRegister(
                      title: '¿Ya tienes cuenta?',
                      subtitle: 'Iniciar sesión',
                      route: SignInScreen.routeName,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
