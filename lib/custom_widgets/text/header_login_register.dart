part of '../custom_widgets.dart';

class HeaderLoginRegister extends StatelessWidget {
  final String headerTitle;

  const HeaderLoginRegister({
    super.key,
    required this.headerTitle,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        LogoImageName(),
        /* SimpleText(
          headerTitle,
          fontSize: 23,
          fontWeight: FontWeight.w700,
          padding: const EdgeInsets.only(top: 15),
        ), */
      ],
    );
  }
}

class LabelLoginRegister extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  const LabelLoginRegister({
    super.key,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => context.push(route),
          child: Column(
            children: [
              /* SimpleText(
                title,
                /* lightThemeColor: Colors.indigo, */
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              SimpleText(
                subtitle,
                /* lightThemeColor: Colors.indigo, */
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ), */
              Column(
                children: [
                  SimpleText(
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                  SimpleText(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: colorSchema.primary,
                    ),
                  ),
                ],
              ),
              /* InkWell(
                onTap: () {
                  print('go to forgot password');
                  context.push(ForgotPasswordScreen.routeName);
                },
                child: const SimpleText(
                  'Olvide mi contraseña ',
                  padding: EdgeInsets.all(5),
                  /* lightThemeColor: Colors.indigo, */
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ), */
            ],
          ),
        )
      ],
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
