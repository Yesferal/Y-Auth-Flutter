/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:y_auth/domain/abstract/auth_remote_storage_datasource.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/model/session_model.dart';
import 'package:y_auth/domain/model/token_model.dart';
import 'package:y_auth/framework/logger/y_log.dart';

class RequestRefreshTokenUseCase {
  RemoteStorageDatasource _remoteStorageDatasource;
  PreferencesDatasource _preferencesDatasource;

  RequestRefreshTokenUseCase(this._remoteStorageDatasource, this._preferencesDatasource);

  Future<AuthResponse> execute(String appPackageName, String authCode, String deviceId, String email) async {
    if (authCode.isEmpty) {
      return ErrorResponse(400, "Invalid code", "Please enter a code");
    }

    var authResponse = await _remoteStorageDatasource.getRefreshTokenFromApi(appPackageName, authCode, deviceId, email);
    switch (authResponse) {
      case ErrorResponse():
        break;

      case SuccessResponse():
        YLog.d("Body: ${authResponse.body}");
        try {
          ApiResponseModel apiResponseModel = ApiResponseModel.fromJson(
              json.decode(authResponse.body));
          if (apiResponseModel.expressToken?.refreshToken != null) {
            _preferencesDatasource.saveRefreshToken(
                apiResponseModel.expressToken?.refreshToken ?? "");
          }
          SessionModel sessionModel = SessionModel.fromJson(
              json.decode(authResponse.body));
          _preferencesDatasource.saveSession(jsonEncode(sessionModel.toJson()));
        } catch (e) {
          YLog.d("RequestRefreshTokenUseCase: Token Model exception: ${e}");
        }

        break;
    }

    return authResponse;
  }
}
