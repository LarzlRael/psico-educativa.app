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
          margin: const EdgeInsets.symmetric(vertical: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* Image.asset(
          'assets/icon.png',
          height: 35,
        ), */
              const SizedBox(width: 10),
              Text(
                headerTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              )
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
