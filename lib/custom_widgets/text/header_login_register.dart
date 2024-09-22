part of '../custom_widgets.dart';

class HeaderLoginRegister extends StatelessWidget {
  final String headerTitle;
  final EdgeInsets? margin;
  const HeaderLoginRegister({
    super.key,
    required this.headerTitle,
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: margin,
      child: Column(
        children: [
          LogoImageName(),
          /* SimpleText(
            headerTitle,
            fontSize: 23,
            fontWeight: FontWeight.w700,
            padding: const EdgeInsets.only(top: 15),
          ), */
        ],
      ),
    );
  }
}

class LabelLoginRegister extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final bool isRow;
  final double spaceBetween;
  final EdgeInsets? margin;
  const LabelLoginRegister({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.isRow = false,
    this.spaceBetween = 0,
    this.margin
  });

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    final content = [
      SimpleText(
        title,
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(
        width: isRow ? spaceBetween : 0,
        height: isRow ? 0 : spaceBetween,
      ),
      SimpleText(
        subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: colorSchema.primary,
        ),
      ),
    ];
    return Container(
      margin: margin,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: isRow
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: content,
                  )
                : Column(
                    children: content,
                  ),
          )
        ],
      ),
    );
  }
}

class LogoImageName extends StatelessWidget {
  const LogoImageName({super.key});
  static const routeName = "";
  @override
  Widget build(BuildContext context) {
    final style = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    return Container(
      width: 300,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          appIcon,
          width: 150,
          height: 120,
          fit: BoxFit.fill,
        ),
        /* const SizedBox(width: 5), */
        /* Align(
          alignment: Alignment.centerLeft,
          child: SimpleText(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            'Psico',
            style: style,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SimpleText(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            'Educativa',
            style: style,
          ),
        ) */
      ]),
    );
  }
}
