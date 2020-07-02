extension StringExtension on String {
  bool get isNumeric => (double.tryParse(this) ?? null) != null;
}
