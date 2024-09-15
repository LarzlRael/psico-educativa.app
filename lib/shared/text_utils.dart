import 'package:flutter/services.dart';

extension StringExtensions on String {
  String toCapitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String toCapitalizeEachWord() {
    if (isEmpty) return '';
    return split(' ').map((word) => word.toCapitalize()).join(' ');
  }
}

String avatarLabel(String username, String? firstName, String? lastName) {
  if ((firstName == null || firstName.isEmpty) &&
      (lastName == null || lastName.isEmpty)) {
    return username.substring(0, 2).toUpperCase();
  }
  return '${firstName ?? ''} ${lastName ?? ''}'.trim();
}

Future<void> copyToClipboard(String value) async {
  await Clipboard.setData(ClipboardData(text: value));
}
