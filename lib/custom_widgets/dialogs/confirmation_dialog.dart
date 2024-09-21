part of '../custom_widgets.dart';

Future<bool?> showCustomConfirmDialog(
  BuildContext context, {
  String title = "Confirmación",
  String content = "¿Estás seguro de que quieres continuar?",
  String cancelText = "Cancelar",
  String acceptText = "Aceptar",
  Function? onAccept,
  Function? onCancel,
}) {
  final color = Theme.of(context).colorScheme.primary;
  return showDialog<bool?>(
    context: context,
    barrierDismissible:
        false, // Evita que el diálogo se cierre al tocar fuera de él
    builder: (BuildContext context) {
      return AlertDialog(
        title: SimpleText(title, fontSize: 18, fontWeight: FontWeight.w700),
        content: SimpleText(content, fontSize: 16, fontWeight: FontWeight.w400),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onCancel?.call();
              Navigator.of(context).pop(false); // Retorna false al cancelar
            },
            child: SimpleText(cancelText, color: Colors.black),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              onAccept?.call();
              Navigator.of(context).pop(true); // Retorna true al aceptar
            },
            child: SimpleText(acceptText, color: Colors.white),
          ),
        ],
      );
    },
  );
}
