part of '../custom_widgets.dart';

enum TypeField {
  text,
  number,
  password,
  email,
  checkbox,
  radio,
  textArea,
  switchField,
  dropdown,
  file,
}

class InputField {
  final IconData? icon;
  final String? placeholder;
  final TypeField typeField;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool clearText;
  final String nameField;
  final dynamic initialValue;
  final String? Function(String?)? validator;
  final Function(BuildContext context, FormFieldState<String>? fieldData)?
      suffixAction;
  final IconData? suffixIcon;
  final List<Map<String, dynamic>>? options;
  InputField({
    this.placeholder,
    this.keyboardType = TextInputType.text,
    required this.nameField,
    required this.typeField,
    this.icon,
    this.suffixIcon,
    this.initialValue,
    this.isPassword = false,
    this.clearText = false,
    this.validator,
    this.suffixAction,
    this.options,
  });
}

class GlobalForm extends HookWidget {
  final List<InputField> fields;
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic> data) onSubmit;
  final String? formTitle;
  final bool? isLoading;
  final String? titleButton;

  GlobalForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.formTitle,
    this.initialData,
    this.isLoading = false,
    this.titleButton = "Guardar",
  });

  final _formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> generateInitialValues() {
    Map<String, dynamic> initialValues = {};
    fields.forEach((i) {
      initialValues = {
        ...initialValues,
        i.nameField: initialData?[i.nameField] ?? i.initialValue,
      };
    });
    return initialValues;
  }

  @override
  Widget build(BuildContext context) {
    final selectedImages = useState<List<String>>([
      ...initialData?['images'] ?? [],
    ]);
    useEffect(() {
      selectedImages.value = initialData?['files'] ?? [];
      return () {};
    }, []);
    return SafeArea(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          initialValue: generateInitialValues(),
          child: Column(
            children: [
              Column(
                children: fields.map((field) {
                  if (field.typeField == TypeField.text ||
                      field.typeField == TypeField.email ||
                      field.typeField == TypeField.password) {
                    return CustomFormBuilderTextField(
                      fieldName: field.nameField,
                      leadingIcon: field.icon,
                      placeholder: field.placeholder!,
                      isPassword: field.isPassword,
                      keyboardType: field.keyboardType,
                      validator: field.validator,
                    );
                  }
                  if (field.typeField == TypeField.number) {
                    return CustomFormBuilderTextField(
                      fieldName: field.nameField,
                      leadingIcon: field.icon,
                      placeholder: field.placeholder!,
                      isPassword: field.isPassword,
                      keyboardType: field.keyboardType,
                      validator: field.validator,
                    );
                  }
                  if (field.typeField == TypeField.textArea) {
                    return CustomFormBuilderTextArea(
                      fieldName: field.nameField,
                      title: field.placeholder!,
                      /* validator: field.validator, */
                      icon: field.icon!,
                      keyboardType: field.keyboardType,
                      /* suffixAction: field.suffixAction,
                      suffixIcon: field.suffixIcon, */
                    );
                  }
                  if (field.typeField == TypeField.switchField) {
                    return CustomSwitch(
                      nameField: field.nameField,
                      /* validator: field.validator, */
                      /* icon: field.icon!, */
                      placeholder: field.placeholder,
                    );
                  }
                  if (field.typeField == TypeField.dropdown) {
                    return CustomDropdown(
                      nameField: field.nameField,
                      placeholder: field.placeholder,
                      options: field.options!,
                    );
                  }
                  /* if (field.typeField == TypeField.file) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: FilePicker(
                        nameField: field.nameField,
                        initialValue: selectedImages.value,
                        onSelectedFiles: (List<String>? files) {
                          selectedImages.value = files ?? [];
                        },
                        onRemoveImage: (file) {
                          selectedImages.value = selectedImages.value
                              .where((element) => element != file)
                              .toList();
                        },
                        takePhoto: (String? photo) {
                          selectedImages.value = [photo ?? ''];
                        },
                      ),
                    );
                  } */

                  return Container();
                }).toList(),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ButtonWithIcon(
                  icon: FontAwesomeIcons.floppyDisk,
                  label: titleButton ?? "Guardar",
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final data = _formKey.currentState!.fields
                        .map((key, value) => MapEntry(key, value.value));
                    if (selectedImages.value.isNotEmpty) {
                      data['images'] = selectedImages.value;
                    }
                    onSubmit(data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
