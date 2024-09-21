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
  final TextDecoration? textDecoration;
  final void Function()? onTap;

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
    this.textDecoration,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textContext = Padding(
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
              decoration: textDecoration,
            ),
      ),
    );

    return onTap == null
        ? textContext
        : InkWell(
            onTap: onTap,
            child: textContext,
          );
  }
}
