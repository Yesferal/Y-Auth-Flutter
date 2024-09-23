/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:email_validator/email_validator.dart';
import 'package:y_auth/domain/abstract/auth_email_validator.dart';

class AuthEmailValidatorImpl extends AuthEmailValidator {

  AuthEmailValidatorImpl();

  @override
  bool validate(String email) {
    return EmailValidator.validate(email);
  }
}
