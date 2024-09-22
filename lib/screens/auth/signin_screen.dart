part of '../screens.dart';

class SignInScreen extends HookConsumerWidget {
  static String routeName = '/signin';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviderN = ref.read(authNotifierProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    final isLocalLoading = useState(false);

    return ScaffoldWithCustomBackground(
      color: Color(0xff2e7c78),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              /* mainAxisAlignment: MainAxisAlignment.spaceEvenly, */
              children: [
                const HeaderLoginRegister(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  headerTitle: 'Iniciar sesión',
                ),
                const Column(
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
                const SizedBox(height: 25),
                FormBuilder(
                  enabled: !isLocalLoading.value,
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormBuilderTextField(
                        borderRadius: 50,
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
                        borderRadius: 50,
                        fieldName: 'password',
                        leadingIcon: FontAwesomeIcons.lock,
                        placeholder: 'Contraseña',
                        isPassword: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SimpleText(
                          textAlign: TextAlign.end,
                          '¿Olvidaste tu contraseña?',
                          padding: const EdgeInsets.only(top: 5, bottom: 15),
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          onTap: () {
                            context.push(
                              ForgotPasswordScreen.routeName,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                LoginButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  borderRadius: 50,
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
                SizedBox(height: 20),
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
                  margin: const EdgeInsets.symmetric(vertical: 10),
                    title: '¿No tienes cuenta?',
                    subtitle: 'Registrate',
                    onTap: ()=> context.push(RegisterScreen.routeName),
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
