part of '../custom_widgets.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backGroundColor;
  final Color textColor;
  final Widget icon;
  final bool showIcon;
  final bool isLoading;
  final double marginVertical;
  final double marginHorizontal;
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor = Colors.blue,
    this.isLoading = false,
    this.textColor = Colors.black,
    this.icon = const Icon(Icons.person),
    this.showIcon = true,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: textColor,
      fontSize: 17.0,
      fontWeight: FontWeight.bold,
    );
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backGroundColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 40.0,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              /* side: BorderSide(color: Colors.red), */
            ),
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
                      Expanded(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: textStyle,
                        ),
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
