part of '../screens.dart';

class VerificationCodeScreen extends HookConsumerWidget {
  const VerificationCodeScreen({super.key});
  static const routeName = "/verification_code_screen";
  @override
  Widget build(BuildContext context, ref) {
    final socketNotifier = ref.read(socketProvider.notifier);
    final socketState = ref.watch(socketProvider);
    final onEditing = useState<bool>(true);
    void handleCodeVerification(String code) async {
      // Enviar el código al servidor
      socketNotifier.sendMessage(
          'code-verification',
          json.encode({
            'code': code,
            'email': 'rael.thassss@gmail.com',
          }));

      // Escuchar la respuesta
      socketState.socket?.on('code-verification', (data) {
        final response = data as Map<String, dynamic>;
        inspect(response);
        if (response['success'] == true) {
          print('Code verification successful from server mada faca');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('CORRECT'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // Manejar el caso cuando la respuesta no es exitosa
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Code verification failed')),
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: Color(0xff2e7c78),
      appBar: AppBar(
        title: const SimpleText('Codigo de verificación',
            color: Colors.white, fontSize: 20),
        backgroundColor: Color(0xff2e7c78),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SimpleText(
                'Ingresa el código de verificación que se le envio a su correo electronico',
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w400),
            const SizedBox(height: 50),
            VerificationCode(
              fullBorder: true,
              fillColor: Colors.white,
              itemSize: 65,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
              keyboardType: TextInputType.number,
              underlineColor: Colors
                  .amber, // If this is null it will use primaryColor: Colors.red from Theme
              length: 4,

              // clearAll is NOT required, you can delete it
              // takes any widget, so you can implement your design
              /* clearAll: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'clear all',
                  style: TextStyle(
                      fontSize: 14.0,
                      decoration: TextDecoration.underline,
                      color: Colors.blue[700]),
                ),
              ), */
              onCompleted: handleCodeVerification,
              onEditing: (bool value) {
                onEditing.value = value;

                if (!onEditing.value) FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: LabelLoginRegister(
                  title: '¿No recibiste el codigo aun?',
                  subtitle: 'Reenviar',
                  isRow: true,
                  spaceBetween: 5,
                  onTap: () {
                    print('Reenviar codigo');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
