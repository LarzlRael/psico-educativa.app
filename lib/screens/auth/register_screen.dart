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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Color(0xff2e7c78),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
              bottom: 15,
              top: 15,
              left: 15.0,
              right: 15.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderLoginRegister(
                  headerTitle: 'Registro',
                ),
                Center(
                  child: SimpleText(
                    'Crea una cuenta',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CustomFormBuilderTextField(
                        borderRadius: 50,
                        fieldName: 'username',
                        leadingIcon: Icons.person,
                        placeholder: 'Nombre de usuario',
                      ),
                      const CustomFormBuilderTextField(
                        borderRadius: 50,
                        fieldName: 'email',
                        keyboardType: TextInputType.emailAddress,
                        leadingIcon: FontAwesomeIcons.at,
                        placeholder: 'Correo electrónico',
                      ),
                      const CustomFormBuilderTextField(
                        borderRadius: 50,
                        fieldName: 'password',
                        leadingIcon: FontAwesomeIcons.lock,
                        placeholder: 'Contraseña',
                        isPassword: true,
                      ),
                      const CustomFormBuilderTextField(
                        borderRadius: 50,
                        fieldName: 'password',
                        leadingIcon: FontAwesomeIcons.lock,
                        placeholder: 'Repetir contraseña',
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                LoginButton(
                  backgroundColor: colorScheme.primary,
                  borderRadius: 50,
                  child: SimpleText(
                    "Registrarse",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),

                  /* borderRadius: 50, */
                  onPressed: () {
                    final validationSuccess = _formKey.currentState!.validate();
                    if (!validationSuccess) return;

                    /* Validated form */

                    _formKey.currentState!.save();
                    isLocalLoading.value = true;
                    /* TODO create a object */
                    authServiceNotifier.register({
                      'username':
                          _formKey.currentState!.value['username'].trim(),
                      'email': _formKey.currentState!.value['email'].trim(),
                      'password':
                          _formKey.currentState!.value['password'].trim(),
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
                Align(
                  alignment: Alignment.center,
                  child: LoginButton(
                    spacing: 20,
                    onPressed: () {
                      /* authProviderN.loginWithGoogle().then((value) {
                          isLocalLoading.value = false;
                        }); */
                    },
                    child: SimpleText(
                      "Registrarse con google",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                    backgroundColor: Colors.white,
                    iconWidget: Image.asset(
                      'assets/icons/google_icon.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                Center(
                  child: LabelLoginRegister(
                    title: '¿Ya tienes cuenta?',
                    subtitle: 'Iniciar sesión',
                    route: SignInScreen.routeName,
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
