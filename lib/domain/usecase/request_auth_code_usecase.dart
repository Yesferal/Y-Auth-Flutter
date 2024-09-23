/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/abstract/auth_email_validator.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';

class RequestAuthCodeUseCase {
  AuthEmailValidator authEmailValidator;

  RequestAuthCodeUseCase(this.authEmailValidator);

  AuthResponse execute(String email) {

    if (!authEmailValidator.validate(email)) {
      const message = "Invalid email";
      return ErrorResponse(message);
    }

    var message = "Your code was sent to $email";
    return SuccessResponse(message);
  }
}
