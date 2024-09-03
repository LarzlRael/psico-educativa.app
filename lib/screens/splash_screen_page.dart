part of 'screens.dart';

class SplashScreenPage extends ConsumerWidget {
  const SplashScreenPage({super.key});
  static const routeName = "/splash_screen_page";
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: Text('Hi from splash_screen_page'),
      ),
    );
  }
}
