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
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
            ),
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
                      const SimpleText(
                        'o',
                        fontSize: 20,
                        color: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      LoginButton(
                        onPressed: () async {
                          /*  var googleinfo =
                              await GoogleSignInServices.signiWithGoogle(); */
                           authProviderN.loginWithGoogle().then((value){
                              /* if() */
                           });
                        },
                        text: "Iniciar sesión con google",
                        backGroundColor: Colors.white,
                        /* icon: SvgPicture.asset(
                          'assets/svg/google_icon.svg',
                          width: 30,
                          height: 30,
                        ), */
                        textColor: Colors.black87,
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
                          if (validationSuccess) {
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
                          }
                        },
                      ),
                      const LabelLoginRegister(
                        title: '¿No tienes cuenta?',
                        subtitle: 'Registrate',
                        route: 'register',
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
