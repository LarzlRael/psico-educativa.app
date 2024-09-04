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

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor,
    this.isLoading = false,
    this.textColor = Colors.black,
    this.icon = const Icon(Icons.person),
    this.showIcon = true,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.fontSize = 17,
    this.spacing = 5,
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
            borderRadius: BorderRadius.circular(15.0),
            /* side: BorderSide(color: Colors.red), */
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : showIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      icon,
                      SizedBox(width: spacing),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  ),
      ),
    );
  }
}
