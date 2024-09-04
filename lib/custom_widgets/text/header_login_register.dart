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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.push('/forgot_password');
          },
          child: const SimpleText(
            'Olvide mi contraseña',
            padding: EdgeInsets.all(5),
            /* lightThemeColor: Colors.indigo, */
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            context.push(route);
          },
          child: Column(
            children: [
              SimpleText(
                 title,
                /* lightThemeColor: Colors.indigo, */
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              SimpleText(
                 subtitle,
                /* lightThemeColor: Colors.indigo, */
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ],
          ),
        )
      ],
    );
  }
}
