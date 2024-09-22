part of '../custom_widgets.dart';

class BackIcon extends StatelessWidget {
  const BackIcon(
      {super.key,
      this.backgroundColor,
      this.icon,
      this.onPressed,
      this.size = 25});
  final Color? backgroundColor;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double size;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? colorScheme.secondary,
      ),
      child: IconButton(
        icon: Icon(icon ?? FontAwesomeIcons.chevronLeft, size: 18),
        onPressed: onPressed ?? context.pop,
      ),
    );
  }
}

class BackSquareIcon extends StatelessWidget {
  const BackSquareIcon({
    super.key,
    this.backgroundColor,
    this.icon,
    this.onPressed,
    this.size = 25,
    this.borderRadius = 10,
  });
  final Color? backgroundColor;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double size;
  final double borderRadius ;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? Color(0xffF8CF92),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(icon ?? FontAwesomeIcons.chevronLeft, size: 18,),
          onPressed: onPressed ?? context.pop,
        ),
      ),
    );
  }
}
