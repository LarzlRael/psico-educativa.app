part of '../custom_widgets.dart';

class CustomFormBuilderTextArea extends StatelessWidget {
  final String fieldName;
  final IconData icon;
  final String title;
  final TextInputType keyboardType;
  const CustomFormBuilderTextArea({
    super.key,
    required this.fieldName,
    required this.icon,
    required this.title,
    this.keyboardType = TextInputType.text,
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
              name: fieldName,
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
