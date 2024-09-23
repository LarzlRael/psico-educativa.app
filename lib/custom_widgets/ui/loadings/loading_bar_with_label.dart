part of '../../custom_widgets.dart';

class LoadingBarWithLabel extends StatelessWidget {
  final String label;
  const LoadingBarWithLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SimpleText(label,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              /* color: Colors.black, */
              ),
          SizedBox(height: 20),
          /* LoadingAnimationWidget(), */
          SizedBox(
            width: 200,
            height: 10,
            child: LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}
