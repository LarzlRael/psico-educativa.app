part of '../custom_widgets.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backGroundColor;

  final Widget? iconWidget;

  final bool isLoading;
  final double marginVertical;
  final double marginHorizontal;

  final double spacing;
  final bool disabled;
  final double borderRadius;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backGroundColor,
    this.isLoading = false,
    this.iconWidget,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.borderRadius = 15,
    this.spacing = 5,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = backGroundColor ?? Theme.of(context).colorScheme.secondary;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 40.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: (isLoading || disabled)
            ? null
            : onPressed, // Aquí se desactiva el botón
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.grey,
              )
            : Row(
                mainAxisAlignment: iconWidget == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start, // Alineación condicional
                children: [
                  iconWidget ?? Container(),
                  SizedBox(
                    width: iconWidget == null ? 0 : 20,
                  ),
                  child,
                ],
              ),
      ),
    );
  }
}
