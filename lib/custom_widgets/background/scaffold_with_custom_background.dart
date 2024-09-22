part of '../custom_widgets.dart';

class ScaffoldWithCustomBackground extends StatelessWidget {
  final Widget body;
  final Color? color;
  final PreferredSizeWidget? appBar;

  const ScaffoldWithCustomBackground({
    super.key,
    required this.body,
    this.appBar,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: color,
      /* extendBodyBehindAppBar: true, */
      body: body,
    );
  }
}
