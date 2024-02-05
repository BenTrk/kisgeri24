import "package:logger/logger.dart";

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 3,
    errorMethodCount: 18,
    lineLength: 140,
    printTime: true,
  ),
);
