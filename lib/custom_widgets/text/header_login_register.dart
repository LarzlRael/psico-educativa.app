part of '../custom_widgets.dart';

class HeaderLoginRegister extends StatelessWidget {
  final String headerTitle;

  const HeaderLoginRegister({
    super.key,
    required this.headerTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                appIcon,
                height: 100,
              ),
              /* const SizedBox(width: 10),
              Text(
                headerTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ) */
              /* SimpleText(
          left: 10,
          text: title,
          /* color: Colors.black, */
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          setUniqueColor: true,
          lightThemeColor: Colors.black,
        ), */
            ],
          ),
        ),
        SimpleText(
          headerTitle,
          fontSize: 25,
          fontWeight: FontWeight.w900,
          padding: const EdgeInsets.all(10),
        ),
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
              RichText(
                text: TextSpan(
                  // Texto y estilo general
                  style: DefaultTextStyle.of(context)
                      .style, // Estilo predeterminado
                  children: <TextSpan>[
                    TextSpan(
                      text: title,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const TextSpan(
                      text: "--",
                      style: TextStyle(
                        color: Colors.transparent,
                      ),
                    ),
                    TextSpan(
                      text: subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: colorSchema.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              InkWell(
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
