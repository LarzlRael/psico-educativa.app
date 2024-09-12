part of '../custom_widgets.dart';

class UserAvatar extends StatelessWidget {
  final String? urlImage;
  final String username;
  final String? firstName;
  final String? lastName;
  final double radius;
  const UserAvatar({
    super.key,
    required this.username,
    this.urlImage,
    this.firstName,
    this.lastName,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    // Si hay una URL de imagen válida, mostramos la imagen
    if (urlImage != null && urlImage!.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(urlImage!),
        radius: radius, // Puedes ajustar el tamaño del avatar aquí
      );
    }

    // Si firstName y lastName son nulos o vacíos, mostramos las 2 primeras letras de username
    String displayText;
    if ((firstName == null || firstName!.isEmpty) &&
        (lastName == null || lastName!.isEmpty)) {
      displayText = username.substring(0, 2).toUpperCase();
    } else {
      // Si hay firstName o lastName, mostramos su combinación
      displayText = '${firstName ?? ''} ${lastName ?? ''}'.trim();
    }

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
          ], // Degradado entre azul y morado
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
