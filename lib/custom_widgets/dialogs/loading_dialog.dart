part of '../custom_widgets.dart';

Future<void> showLoadingDialog(BuildContext context, {String? message}) {
  return showDialog(

    context: context,
    barrierDismissible:
        false, // No permite cerrar el diálogo al tocar fuera de él
    builder: (BuildContext context) {
      return  AlertDialog(
        content: Row(
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text(message ?? 'Cargando...'),
          ],
        ),
      );
    },
  );
}
