import 'dart:convert';

import 'package:flutter/foundation.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

Future parseJsonInBackground(String text) {
  return compute(_parseAndDecode, text);
}
