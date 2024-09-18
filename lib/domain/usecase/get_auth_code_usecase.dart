/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:flutter/material.dart';

class GetAuthCodeUseCase {

  GetAuthCodeUseCase();

  Future<String?> execute(String email) async {
    var message = "Your code was sent to $email";
    debugPrint(message);

    return message;
  }
}
