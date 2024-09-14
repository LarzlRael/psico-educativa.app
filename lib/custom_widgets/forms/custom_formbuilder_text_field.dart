part of '../custom_widgets.dart';

class CustomFormBuilderTextField extends HookWidget {
  final String name;
  final IconData? leadingIcon;
  final Widget? trailingIcon;
  final String placeholder;
  final bool passwordField;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? margin;
  const CustomFormBuilderTextField({
    super.key,
    required this.name,
    required this.placeholder,
    this.leadingIcon,
    this.trailingIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.passwordField = false,
    this.margin = const EdgeInsets.symmetric(vertical: 5.0),
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);

    return Container(
      margin: margin,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: FormBuilderTextField(
          keyboardType: keyboardType,
          obscureText: passwordField && obscureText.value,
          name: name,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: placeholder,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            suffixIcon: passwordField
                ? IconButton(
                    icon: obscureText.value
                        ? const Icon(FontAwesomeIcons.eyeSlash, size: 15)
                        : const Icon(FontAwesomeIcons.eye, size: 15),
                    onPressed: () => obscureText.value = !obscureText.value,
                  )
                : trailingIcon,
            prefixIcon: Icon(leadingIcon, size: 15),
          ),
        ),
      ),
    );
  }
}
