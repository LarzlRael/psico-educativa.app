part of '../../custom_widgets.dart';

class LoadingBarWithLabel extends StatelessWidget {
  final String label;
  const LoadingBarWithLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleText(label,
            style: Theme.of(context).textTheme.displayMedium
            /* fontSize: 20, */
            /* color: Colors.black, */
            ),
        SizedBox(height: 20),
        LoadingAnimationWidget(),
      ],
    );
  }
}
