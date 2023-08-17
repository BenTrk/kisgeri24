import 'dart:developer';

class CustomException {
  CustomException(String message) {
    log(message);
  }

  static noSnapshotException() {
    throw CustomException('No snapshot found.');
  }
}
