part of '../custom_widgets.dart';

class CustomFormBuilderTextField extends HookWidget {
  final String fieldName;
  final IconData? leadingIcon;
  final Widget? trailingIcon;
  final String? placeholder;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? margin;
  final String? label;
  final double borderRadius;
  final Color? backgroundColor;
  const CustomFormBuilderTextField({
    super.key,
    required this.fieldName,
    this.backgroundColor,
    this.placeholder,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.borderRadius = 15,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.margin = const EdgeInsets.symmetric(vertical: 5.0),
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);

    return Container(
      margin: margin,
      child: Column(
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SimpleText(
                  label!,
                  /* color: Colors.grey, */
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: leadingIcon == null ? 20 : 0),
              child: FormBuilderTextField(
                keyboardType: keyboardType,
                obscureText: isPassword && obscureText.value,
                name: fieldName,
                validator: validator,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: placeholder,
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: obscureText.value
                              ? const Icon(FontAwesomeIcons.eyeSlash, size: 15)
                              : const Icon(FontAwesomeIcons.eye, size: 15),
                          onPressed: () =>
                              obscureText.value = !obscureText.value,
                        )
                      : trailingIcon,
                  prefixIcon: leadingIcon == null
                      ? null
                      : Icon(
                          leadingIcon,
                          size: 15,
                          color: Colors.grey,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
