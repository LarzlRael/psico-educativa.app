part of '../custom_widgets.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;

  final Color? color;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  final TextAlign? textAlign;
  final double? lineHeight;

  const SimpleText(
    this.text, {
    super.key,
    this.fontWeight,
    this.padding,
    this.fontSize,
    this.style,
    this.textAlign,
    this.lineHeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        style: style ??
            TextStyle(
              height: lineHeight,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontSize: fontSize ?? 14,
              color: color,
            ),
      ),
    );
  }
}
