import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(
  level: kDebugMode ? Level.debug : Level.nothing,
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: false,
    printEmojis: false,
    printTime: true,
  ),
);
