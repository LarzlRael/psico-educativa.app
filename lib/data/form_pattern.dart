import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:psico_educativa_app/custom_widgets/custom_widgets.dart';
import 'package:psico_educativa_app/shared/text_utils.dart';
/* import 'package:handbag/utils/utils.dart'; */

final customerAddOrEditFields = <InputField>[
  InputField(
    nameField: "name",
    typeField: TypeField.text,
    icon: Icons.person,
    placeholder: "Nombre del cliente",
    validator: FormBuilderValidators.required(),
  ),
  InputField(
    nameField: "phoneNumber",
    typeField: TypeField.number,
    placeholder: "Telefono",
    icon: Icons.phone,
  ),
  InputField(
    nameField: "urlFacebookProfile",
    typeField: TypeField.text,
    placeholder: "Url de perfil de facebook",
    validator: FormBuilderValidators.url(),
    icon: Icons.facebook,
  ),
  InputField(
    nameField: "notes",
    typeField: TypeField.textArea,
    placeholder: "Notas",
  ),
];

/* List of Field */
List<InputField> productsFormFields = <InputField>[
  InputField(
    typeField: TypeField.file,
    nameField: "files",
    placeholder: "Seleccionar fotos",
    validator: FormBuilderValidators.required(),
  ),
  InputField(
    typeField: TypeField.text,
    nameField: "name",
    placeholder: "Nombre del producto (*)",
    validator: FormBuilderValidators.required(),
  ),
  InputField(
    typeField: TypeField.text,
    nameField: "postUrl",
    placeholder: "Ingrese la url del producto",
    validator: FormBuilderValidators.url(),
  ),
  InputField(
    typeField: TypeField.textArea,
    nameField: "description",
    placeholder: "Descripcion del producto",
    validator: FormBuilderValidators.required(),
    suffixAction: (context, field) {
      if (field == null || field.value == null) return;
      copyToClipboard(field.value!).then((value) {
        /* GlobalSnackBar.show(
          context,
          "Copiado al portapapeles",
          backgroundColor: Colors.blue,
        ); */
      });
    },
    suffixIcon: Icons.copy,
  ),
  InputField(
    typeField: TypeField.number,
    keyboardType: TextInputType.number,
    nameField: "quantity",
    placeholder: "Cantidad de producto (*)",
    validator: FormBuilderValidators.required(),
  ),
  InputField(
    typeField: TypeField.number,
    nameField: "bulkPricing",
    keyboardType: TextInputType.number,
    placeholder: "Precio por unidad (*)",
    validator: FormBuilderValidators.required(),
  ),
  InputField(
    typeField: TypeField.number,
    nameField: "materials",
    keyboardType: TextInputType.text,
    placeholder: "Materiales",
  ),
  InputField(
    typeField: TypeField.text,
    nameField: "colors",
    keyboardType: TextInputType.text,
    placeholder: "Colores (Separar por comas ',')",
  ),
];
