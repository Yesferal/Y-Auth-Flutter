/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/model/auth_response_model.dart';

class ValidateAuthCodeUseCase {

  ValidateAuthCodeUseCase();

  Future<AuthResponse> execute(String authCode) async {
    if (authCode.isEmpty) {
      return ErrorResponse("Invalid code");
    }

    return SuccessResponse("$authCode is a valid authentication code.");
  }
}
