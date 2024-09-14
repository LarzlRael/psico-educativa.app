part of '../custom_widgets.dart';

class UserAvatar extends StatelessWidget {
  final String username;
  final String? firstName;
  final String? lastName;
  final double radius;
  final Widget? customWidget; // Nuevo parámetro para el widget personalizado

  const UserAvatar({
    super.key,
    required this.username,
    this.firstName,
    this.lastName,
    this.radius = 20,
    this.customWidget, // Inicialización del nuevo parámetro
  });

  @override
  Widget build(BuildContext context) {
    // Si se proporciona un widget personalizado, lo mostramos
    if (customWidget != null) {
      return Container(
        width: radius * 2,
        height: radius * 2,
        child: ClipOval(
          child: customWidget,
        ),
      );
    }

    // Si firstName y lastName son nulos o vacíos, mostramos las 2 primeras letras de username
    final displayText = avatarLabel(username, firstName, lastName);

    // Mostrar un avatar con texto
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.green,
            Colors.green.withOpacity(0.4)
          ], // Degradado entre verde y verde con opacidad
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors
            .transparent, // Hacemos el CircleAvatar transparente para ver el degradado
        child: SimpleText(
          displayText,
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
