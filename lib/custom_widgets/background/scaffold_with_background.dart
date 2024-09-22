part of '../custom_widgets.dart';

class ScaffoldWithBackground extends StatelessWidget {
  final Widget child;
  final Widget? customShapeBackground;
  const ScaffoldWithBackground({
    super.key,
    required this.child,
    this.appBar,
    this.customShapeBackground,
  });
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appBar,
      body: SizedBox.expand(
        /* child: BackgroundWithBlurredCircles(
          child: child,
        ), */
        child: BackgroundOneCircle(
          customShapeBackground: customShapeBackground,
          child: child,
        ),
      ),
    );
  }
}

class HeaderBorderRounded extends StatelessWidget {
  const HeaderBorderRounded({
    super.key,
    this.height = 250,
    this.color,
    this.contentWidget,
  });
  static const routeName = "";
  final double? height;
  final Color? color;
  final Widget? contentWidget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip
          .none, // Para permitir que el círculo se desborde fuera del contenedor
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        // Posiciona el círculo en el centro, abajo
        Positioned(
          bottom:
              -50, // La mitad del tamaño del círculo (ajústalo según el tamaño)
          left: 0,
          right: 0,
          child: Center(
            child: contentWidget,
          ),
        ),
      ],
    );
  }
}
