part of '../custom_widgets.dart';

class CustomSwitch extends StatelessWidget {
  final String nameField;
  final bool initialValue;
  final String? placeholder;
  final String? Function(bool?)? validator;
  const CustomSwitch({
    super.key,
    required this.nameField,
    this.initialValue = false,
    this.placeholder,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderSwitch(
      name: nameField,
      initialValue: false,
      title: Text(placeholder ?? ""),
      validator: validator,
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
      ),
    );
  }
}
