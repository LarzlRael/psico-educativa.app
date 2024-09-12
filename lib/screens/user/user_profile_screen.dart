part of '../screens.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});
  static const routeName = "/user-profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Perfil de usuario'),
      ), */
      body: SafeArea(
        child: BackgroundWithBlurredCircles(
          child: Text('Hi from user_profile_screen'),
        ),
      ),
    );
  }
}
