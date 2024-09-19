/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:email_validator/email_validator.dart';

class ValidateEmailUseCase {

  ValidateEmailUseCase();

  bool execute(String email) {
    return EmailValidator.validate(email);
  }
}
