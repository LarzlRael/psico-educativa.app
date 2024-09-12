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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const HeaderLoginRegister(
                  headerTitle: 'Iniciar sesión',
                ),
                FormBuilder(
                  enabled: !isLocalLoading.value,
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormBuilderTextField(
                        name: 'username',
                        icon: FontAwesomeIcons.at,
                        keyboardType: TextInputType.emailAddress,
                        placeholder: 'Nombre de usuario o email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const CustomFormBuilderTextField(
                        name: 'password',
                        icon: FontAwesomeIcons.lock,
                        placeholder: 'Contraseña',
                        passwordField: true,
                      ),
                    ],
                  ),
                ),
                LoginButton(
                  isLoading: !isLocalLoading.value,
                  text: "Iniciar sesión",
                  textColor: Colors.white,
                  showIcon: false,
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
                        Navigator.pushNamed(context, '/home_screen');
                      }
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
                  fontSize: 14,
                  /* TODO disable google button while is loading */
                  /* isLoading: isLocalLoading.value, */
                  fontWeight: FontWeight.normal,
                  onPressed: () async {
                    await authProviderN.loginWithGoogle();
                    isLocalLoading.value = false;
                  },
                  text: "Iniciar sesión con google",
                  backGroundColor: Colors.white,
                  icon: Image.asset(
                    'assets/icons/google_icon.png',
                    width: 30,
                    height: 30,
                  ),
                  textColor: Colors.black87,
                ),
                LabelLoginRegister(
                  title: '¿No tienes cuenta?',
                  subtitle: 'Registrate',
                  route: RegisterScreen.routeName,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
