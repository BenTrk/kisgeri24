import 'package:kisgeri24/logging.dart';

class LogUtils {
  static const int debugThreshold = int.fromEnvironment(
      'OPERATION_DURATION_DEBUG_THRESHOLD',
      defaultValue: 2);
  static const int infoThreshold =
      int.fromEnvironment('OPERATION_DURATION_INFO_THRESHOLD', defaultValue: 3);

  static int logStart({String prefixMsg = 'Operation '}) {
    logger.d('$prefixMsg started.');
    return DateTime.timestamp().millisecondsSinceEpoch;
  }

  static void logEnd(int since, {String prefixMsg = 'Operation'}) {
    double took = (DateTime.timestamp().millisecondsSinceEpoch - since) / 1000;
    String msg = '$prefixMsg took ${took}s';
    if (took < debugThreshold.toDouble()) {
      logger.d(msg);
    } else if (took >= debugThreshold.toDouble() &&
        took < infoThreshold.toDouble()) {
      logger.i(msg);
    } else if (took >= infoThreshold.toDouble()) {}
    logger.w(msg);
  }
}
