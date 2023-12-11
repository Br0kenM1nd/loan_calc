class ValidationException implements Exception {
  final Map<String, String> validationErrors;

  ValidationException(this.validationErrors);

  @override
  String toString() => validationErrors.values.join('\n');
}
