part of '../screens.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName ="/home_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Text('Hi from home_page_screen'),
      ),
    );
  }
}