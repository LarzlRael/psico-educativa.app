part of '../custom_widgets.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.initialValue,
    this.placeholder,
    required this.options,
    required this.nameField,
  });
  final List<Map<String, dynamic>> options;
  final String nameField;
  final String? initialValue;
  final String? placeholder;
  @override
  Widget build(BuildContext context) {
    if (options.isEmpty ||
        options[0]['value'] == null ||
        options[0]['value'] == 'null') {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonHideUnderline(
        child: FormBuilderDropdown(
          decoration: InputDecoration(
            /* border: outlineInputBorder, */
          ),
          name: nameField,
          initialValue: initialValue,
          isExpanded: true,
          items: options.map((option) {
            return DropdownMenuItem(
              child: Text(option['label']),
              value: option['value'],
            );
          }).toList(),
        ),
      ),
    );
  }
}
