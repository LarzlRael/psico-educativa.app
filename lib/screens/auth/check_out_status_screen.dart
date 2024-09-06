part of '../screens.dart';

class CheckOutStatusScreen extends ConsumerWidget {
  static String routeName = '/';
  const CheckOutStatusScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
