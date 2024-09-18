import 'package:flutter/services.dart';
import 'package:psico_educativa_app/shared/validations.dart';

extension StringExtensions on String {
  String toCapitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String toTitleCase() {
    if (isEmpty) return '';
    return split(' ').map((word) => word.toCapitalize()).join(' ');
  }
}

/* Enhance this code to handle additional cases */

String avatarLabel(String username, String? firstName, String? lastName) {
  if ((isValidateString(firstName)) && isValidateString(lastName)) {
    return '${firstName![0]}${lastName![0]}'.toUpperCase();
  }
  return username.substring(0, 2).toUpperCase();
}

Future<void> copyToClipboard(String value) async {
  await Clipboard.setData(ClipboardData(text: value));
}
