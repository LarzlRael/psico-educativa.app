extension StringExtensions on String {
  String toCapitalize() => isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
}
