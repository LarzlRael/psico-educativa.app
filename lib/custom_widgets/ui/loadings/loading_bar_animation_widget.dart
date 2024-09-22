part of '../../custom_widgets.dart';
/* const height = 15.0; */

class LoadingAnimationWidget extends StatefulWidget {
  const LoadingAnimationWidget({super.key});

  @override
  State<LoadingAnimationWidget> createState() => _LoadingAnimationWidgetState();
}

class _LoadingAnimationWidgetState extends State<LoadingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Duración rápida
      vsync: this,
    )..repeat(reverse: false);

/* TODO fix this */
    // Ajustar el valor de "begin" y "end" para que la animación empiece fuera del contenedor
    final height = 15.0;
    final rectWidth = height ; // Ancho del rectángulo animado
    final containerWidth = 200.0; // Ancho del contenedor

    // El rectángulo debe comenzar desde fuera del contenedor (por eso -rectWidth)
    _animation = Tween<double>(begin: -rectWidth, end: containerWidth).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0, 0.8, // La animación toma el 80% del tiempo
          curve: Curves.easeInOut, // Efecto suave al inicio y al final
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = 15.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // Borde redondeado del contenedor
      child: Container(
        width: 200, // Ancho del contenedor
        height: height, // Alto del contenedor
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  left: _animation.value, // Posición animada del recuadro
                  child: Container(
                    width: height * 6.5, // Ancho del recuadro animado
                    height: height, // Alto del recuadro animado
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Color del recuadro
                      borderRadius: BorderRadius.circular(12), // Borde redondeado
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}