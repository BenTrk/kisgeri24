class MultipleElementError extends Error {
  final String message;

  MultipleElementError(this.message);

  @override
  String toString() {
    return 'CustomError: $message';
  }
}
