part of '../custom_widgets.dart';

Future<void> confirmatedDialog(BuildContext context,
    {String? message, String content = ''}) {
  return showDialog(
    context: context,
    barrierDismissible:
        false, // No permite cerrar al hacer clic fuera del diálogo
    builder: (BuildContext context) {
      return Stack(
        clipBehavior: Clip
            .none, // Permite que los elementos se desborden fuera del diálogo
        children: <Widget>[
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Bordes redondeados
            ),
            child: Padding(
              padding: const EdgeInsets.all(20), // Espaciado interior
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícono de confirmación
                  Image.asset(
                    'assets/icons/check_icon.png',
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(height: 10),
                  // Mensaje de felicitaciones
                  const Text(
                    'Felicitaciones',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Mensaje de confirmación
                  const Text(
                    'Tu perfil ha sido actualizado correctamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Botón flotante para cerrar el diálogo
          Positioned(
            bottom: 160, // Ajusta la distancia del botón respecto al diálogo
            left: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: Center(
                  child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, weight: 10,),
                onPressed:context.pop,
              )),
            ),
          ),
        ],
      );
    },
  );
}
