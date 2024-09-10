part of '../screens.dart';

class VerificationCodeScreen extends HookWidget {
  const VerificationCodeScreen({super.key});
  static const routeName = "/verification_code_screen";
  @override
  Widget build(BuildContext context) {
    final code = useState<String>('1234');
    final onEditing = useState<bool>(true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Code'),
      ),
      body: Center(
        child: VerificationCode(
          textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
          keyboardType: TextInputType.number,
          underlineColor: Colors
              .amber, // If this is null it will use primaryColor: Colors.red from Theme
          length: 4,
          cursorColor:
              Colors.blue, // If this is null it will default to the ambient
          // clearAll is NOT required, you can delete it
          // takes any widget, so you can implement your design
          clearAll: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'clear all',
              style: TextStyle(
                  fontSize: 14.0,
                  decoration: TextDecoration.underline,
                  color: Colors.blue[700]),
            ),
          ),
          onCompleted: (String value) {
            code.value = value;
            if (value == code.value) {
              print('Code is correct');
            } else {
              print('Code is incorrect');
            }
          },
          onEditing: (bool value) {
            onEditing.value = value;

            if (!onEditing.value) FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
