part of '../custom_widgets.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? backGroundColor;
  final Color textColor;
  final Widget icon;
  final bool showIcon;
  final bool isLoading;
  final double marginVertical;
  final double marginHorizontal;
  final double fontSize;
  final double spacing;
  final FontWeight fontWeight;
  final bool disabled;
  final double borderRadius;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor,
    this.isLoading = false,
    this.textColor = Colors.black,
    this.icon = const Icon(Icons.person),
    this.showIcon = false,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.fontSize = 17,
    this.borderRadius = 15,
    this.spacing = 5,
    this.disabled = false,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
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
        onPressed: (isLoading || disabled) ? null : onPressed, // Aquí se desactiva el botón
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.grey,
              )
            : Row(
                mainAxisAlignment: showIcon
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center, // Alineación condicional
                children: [
                  if (showIcon) ...[
                    icon,
                    SizedBox(width: spacing),
                  ],
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ],
              ),
      ),
    );
  }
}
