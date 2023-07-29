import 'dart:developer';

class customException {

  customException(String message){
    log(message);
  }

  static noSnapshotException() {
    throw customException('No snapshot found.');
  }
}