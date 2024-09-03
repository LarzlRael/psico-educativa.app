part of '../custom_widgets.dart';

class CustomFormBuilderTextArea extends StatelessWidget {
  final String name;
  final IconData icon;
  final String title;
  final bool passwordField;
  final TextInputType keyboardType;
  const CustomFormBuilderTextArea({
    super.key,
    required this.name,
    required this.icon,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.passwordField = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
           title,
          fontSize: formSizeLabel,
          fontWeight: FontWeight.w700,
          /* bottom: 5, */
        ),
        Card(
          elevation: cardElevation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FormBuilderTextField(
              keyboardType: keyboardType,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              name: name,
              validator: FormBuilderValidators.required(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
