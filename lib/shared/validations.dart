import 'package:flutter/material.dart';

bool validateStatus(int? state) {
  const status = [200, 201, 202, 203, 204];
  return state == null ? false : status.contains(state);
}

bool validateArray(List<dynamic> dataArray) {
  return (dataArray.isNotEmpty ? true : false);
}

bool validateEmail(String email) {
  return !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

void navigatorProtected(
    BuildContext context, bool isLogged, String route, dynamic arguments) {
  if (isLogged) {
    Navigator.pushNamed(context, route, arguments: arguments);
  } else {
    Navigator.pushReplacementNamed(context, 'welcome');
  }
}

String validateString(String? value) {
  return value ?? '';
}

bool isValidateString(String? value) =>
    // Verifica que la cadena no sea 'null', no sea nula y no esté vacía
    value != null && value.trim() != 'null' && value.trim().isNotEmpty;
