part of '../screens.dart';

class SignInScreen extends HookConsumerWidget {
  static String routeName = '/signin';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviderN = ref.read(authNotifierProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    final isLocalLoading = useState(false);

    return Scaffold(
      backgroundColor: Color(0xff2e7c78),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const HeaderLoginRegister(
                  headerTitle: 'Iniciar sesión',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      'Bienvenido de nuevo!',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    SimpleText(
                      'Inicio de sesión con tu cuenta para continuar',
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
                FormBuilder(
                  enabled: !isLocalLoading.value,
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormBuilderTextField(
                        fieldName: 'username',
                        leadingIcon: FontAwesomeIcons.at,
                        keyboardType: TextInputType.emailAddress,
                        placeholder: 'Nombre de usuario o email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      /* dont user const, BUG 🐛 */
                      CustomFormBuilderTextField(
                        fieldName: 'password',
                        leadingIcon: FontAwesomeIcons.lock,
                        placeholder: 'Contraseña',
                        isPassword: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SimpleText(
                          textAlign: TextAlign.end,
                          'Olvide mi contraseña',
                          padding: const EdgeInsets.all(2),
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          onTap: () {
                            context.push(ForgotPasswordScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                LoginButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  isLoading: isLocalLoading.value,
                  child: SimpleText(
                    "Iniciar sesión",
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () async {
                    final validationSuccess =
                        formKey.currentState?.validate() ?? false;

                    if (!validationSuccess) return;

                    formKey.currentState?.save();

                    isLocalLoading.value = true;
                    final resp = await authProviderN.login(
                      formKey.currentState?.value['username'],
                      formKey.currentState?.value['password'],
                    );

                    isLocalLoading.value = false;

                    if (resp) {
                      if (context.mounted) {
                        toastification.show(
                          context:
                              context, // optional if you use ToastificationWrapper
                          title: Text('Bienvenido'),
                          backgroundColor: Colors.green,
                          alignment: Alignment.bottomCenter,
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                        context.push(HomeScreen.routeName);
                      }
                    } else {
                      toastification.show(
                        type: ToastificationType.error,
                        title: Text('Usuario o contraseña error'),
                        primaryColor: Colors.orange,
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    }
                  },
                ),
                const SimpleText(
                  'O',
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.grey,
                ),
                LoginButton(
                  spacing: 20,
                  /* TODO disable google button while is loading */
                  disabled: isLocalLoading.value,
                  onPressed: () async {
                    await authProviderN.loginWithGoogle();
                    isLocalLoading.value = false;
                  },
                  child: SimpleText(
                    "Iniciar sesión con google",
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
                Center(
                  child: LabelLoginRegister(
                    title: '¿No tienes cuenta?',
                    subtitle: 'Registrate',
                    route: RegisterScreen.routeName,
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
