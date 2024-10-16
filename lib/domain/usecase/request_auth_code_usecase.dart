/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/abstract/auth_email_validator.dart';
import 'package:y_auth/domain/abstract/auth_remote_storage_datasource.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';

class RequestAuthCodeUseCase {
  AuthEmailValidator authEmailValidator;
  RemoteStorageDatasource remoteStorageDatasource;

  RequestAuthCodeUseCase(this.authEmailValidator, this.remoteStorageDatasource);

  Future<AuthResponse> execute(String appColor, String appName, String email) async {

    if (!authEmailValidator.validate(email)) {
      const message = "Invalid email";
      return ErrorResponse(message, "Please verify that your email address is correct");
    }

    final AuthResponse response = await this.remoteStorageDatasource.getAuthCodeFromApi(appColor, appName, email);
    return response;
  }
}
