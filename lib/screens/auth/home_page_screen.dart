part of '../screens.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = "/";
  @override
  Widget build(BuildContext context, ref) {
    final authProviderN = ref.watch(authNotifierProvider.notifier);
    return Scaffold(
      body: Center(
        child: FilledButton(
            onPressed: () async {
              await authProviderN.logout();
            },
            child: Text('cerrar sesion')),
      ),
    );
  }
}
