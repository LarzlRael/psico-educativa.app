part of '../custom_widgets.dart';

enum ShimmerShape { rectangle, circle, rounded }

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.height = 50,
    this.width,
    this.shape = ShimmerShape.rectangle,
    this.borderRadius = 8.0,
    this.margin,
  });

  final double height;
  final double? width;
  final Color? baseColor;
  final Color? highlightColor;
  final ShimmerShape shape;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Color(0xffB0B0B0),
      highlightColor: highlightColor ?? Colors.grey,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: highlightColor ?? Colors.grey,
          borderRadius: shape == ShimmerShape.rounded
              ? BorderRadius.circular(borderRadius)
              : null,
          shape: shape == ShimmerShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
        ),
      ),
    );
  }
}