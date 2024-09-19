/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/usecase/validate_email_usecase.dart';

class GetAuthCodeUseCase {
  ValidateEmailUseCase validateEmailUseCase;

  GetAuthCodeUseCase(this.validateEmailUseCase);

  AuthResponse execute(String email) {

    if (!validateEmailUseCase.execute(email)) {
      const message = "Invalid email";
      return ErrorResponse(message);
    }

    var message = "Your code was sent to $email";
    return SuccessResponse(message);
  }
}
