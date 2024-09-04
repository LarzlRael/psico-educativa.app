part of '../screens.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = "/";
  @override
  Widget build(BuildContext context, ref) {
    final authProviderN = ref.watch(authNotifierProvider.notifier);
    final authProviderS = ref.read(authNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello ${authProviderS.user?.username}'),
            Text('token ${authProviderS.user?.accessToken}'),
            FilledButton(
                onPressed: () async {
                  await authProviderN.logout();
                },
                child: Text('cerrar sesion',style:TextStyle(color:Colors.black))),
          ],
        ),
      ),
    );
  }
}
