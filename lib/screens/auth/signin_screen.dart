part of '../screens.dart';

class SignInScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  static String routeName = '/signin';

  SignInScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final authProviderN = ref.watch(authNotifierProvider.notifier);
    final authProviderS = ref.read(authNotifierProvider);
    /* final globalProviderState = ref.watch(globalProvider); */
    /* final authService = Provider.of<AuthServices>(context); */
    final isLocalLoading = useState<bool>(false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FormBuilder(
              enabled: !isLocalLoading.value,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const HeaderLoginRegister(
                        headerTitle: 'Iniciar sesión',
                      ),

                      /* FormBuilderTextField(
                    name: 'username',
                    validator: FormBuilderValidators.required(),
                    decoration: const InputDecoration(
                      labelText: 'Nombre de usuario',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ), */
                      const CustomFormBuilderTextField(
                        name: 'username',
                        icon: FontAwesomeIcons.at,
                        placeholder: 'Nombre de usuario o email',
                      ),
                      /*  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    validator: FormBuilderValidators.required(),
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(
                        Icons.password_outlined,
                      ),
                    ),
                  ), */
                      const CustomFormBuilderTextField(
                        name: 'password',
                        icon: FontAwesomeIcons.lock,
                        placeholder: 'Contraseña',
                        passwordField: true,
                      ),

                      /* RaisedButton(
                    onPressed: () async {
                      await authService.logout();
                    },
                    child: Text('Cerrar sesion'),
                  ), */
                    ],
                  ),
                  Column(
                    children: [
                      LoginButton(
                        isLoading: isLocalLoading.value,
                        text: "Iniciar sesión",
                        textColor: Colors.white,
                        showIcon: false,
                        onPressed: () async {
                          final validationSuccess =
                              _formKey.currentState!.validate();
                          print(_formKey.currentState!.value['username']);
                          print(_formKey.currentState!.value['password']);
                          if (!validationSuccess) return;
                          _formKey.currentState!.save();
                          isLocalLoading.value = true;
                          authProviderN
                              .login(_formKey.currentState!.value['username'],
                                  _formKey.currentState!.value['password'])
                              .then((value) {
                            isLocalLoading.value = false;
                            /* if (value) {
                                context.push('/home_screen');
                              } else {
                                isLocalLoading.value = false;
                              } */
                          });
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
                        fontWeight: FontWeight.normal,
                        onPressed: () {
                          authProviderN.loginWithGoogle().then((value) {
                            isLocalLoading.value = false;
                          });
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
                      /* Spacer(), */
                      LabelLoginRegister(
                        title: '¿No tienes cuenta?',
                        subtitle: 'Registrate',
                        route: VerificationCodeScreen.routeName,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
