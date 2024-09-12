part of '../custom_widgets.dart';

class BackgroundWithBlurredCircles extends StatelessWidget {
  final Widget child;

  const BackgroundWithBlurredCircles({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        // Fondo negro
        Container(color: Colors.black),

        // Círculo difuminado en la esquina superior izquierda
        Positioned(
          top: -175,
          left: -175,
          child: CircleBlurred(
            radius: 250,
            colors: [colorScheme.primary.withOpacity(0.5), Colors.transparent],
          ),
        ),

        // Círculo difuminado en el centro-derecha
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          right: -150,
          child: CircleBlurred(
            radius: 200,
            colors: [colorScheme.secondary.withOpacity(0.30), Colors.transparent],
            blurAmount: 20,
          ),
        ),

        // Círculo difuminado en la esquina inferior izquierda
        Positioned(
          bottom: -200,
          left: -200,
          child: CircleBlurred(
            radius: 200,
            colors: [Color(0xffB4AAFF).withOpacity(0.25), Colors.transparent],
          ),
        ),

        // Child que pasa el contenido encima del fondo
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}

class CircleBlurred extends StatelessWidget {
  final double radius;
  final List<Color> colors;
  final double blurAmount;

  const CircleBlurred({
    super.key,
    required this.radius,
    required this.colors,
    this.blurAmount = 10.0, // Valor del desenfoque por defecto
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // El círculo con gradiente
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: colors,
              center: Alignment.center,
              radius: 1,
            ),
          ),
        ),
        
        // Aplicación del efecto de blur
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurAmount, // Desenfoque en el eje X
              sigmaY: blurAmount, // Desenfoque en el eje Y
            ),
            child: Container(
              color: Colors.transparent, // Fondo transparente para ver el blur
            ),
          ),
        ),
      ],
    );
  }
}
