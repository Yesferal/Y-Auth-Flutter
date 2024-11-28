/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:flutter/foundation.dart';

class YLog {
  static d(String message) {
    if (kDebugMode) {
      debugPrint("YLog: $message");
    }
  }
}
