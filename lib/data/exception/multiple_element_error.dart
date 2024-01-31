class MultipleElementException implements Exception {
  final String message;

  MultipleElementException(this.message);

  @override
  String toString() {
    return 'MultipleElementException: $message';
  }
}
