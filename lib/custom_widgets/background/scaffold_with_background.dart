part of '../custom_widgets.dart';

class ScaffoldWithBackground extends StatelessWidget {
  final Widget child;
  const ScaffoldWithBackground({super.key, required this.child, this.appBar});
final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: appBar,
      body: SizedBox.expand(
        child: BackgroundWithBlurredCircles(
          child: child,
        ),
      ),
    );
  }
}
