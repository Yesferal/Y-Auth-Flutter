/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/model/token_model.dart';
import 'package:y_auth/domain/usecase/request_access_token_usecase.dart';
import 'package:y_auth/domain/usecase/sign_out_usecase.dart';
import 'package:y_auth/framework/logger/y_log.dart';

class GetAccessTokenUseCase {
  PreferencesDatasource _preferencesDatasource;
  RequestAccessTokenUseCase _requestAccessTokenUseCase;
  SignOutUseCase _signOutUseCase;
  TokenModel? tokenModel;

  /// This Delta is used to avoid errors.
  /// The expiration time will be precise.
  /// However, we're not accounting for server response delay,
  /// which could range from 1 to any seconds.
  /// We believe that 60 seconds is a good estimate.
  final REQUEST_DELTA_IN_MILLISECONDS = 60 /* Sec */ * 1000;

  GetAccessTokenUseCase(this._preferencesDatasource,
      this._requestAccessTokenUseCase, this._signOutUseCase);

  void execute(Function(TokenModel? tokenModel) onComplete,
      Function(String) onErrorRefreshTokenExpired,
      {forceNewToken = false}) async {
    int? expiredIn = tokenModel?.expressToken?.expiredIn;
    int? requestedAt = tokenModel?.expressToken?.requestedAt;
    if (!forceNewToken && expiredIn != null && requestedAt != null) {
      int nowInMilliseconds = DateTime.now().millisecondsSinceEpoch;
      int lastTokenRequestPlusDelta =
          requestedAt + REQUEST_DELTA_IN_MILLISECONDS;
      bool tokenHasExpired =
          expiredIn < (nowInMilliseconds - lastTokenRequestPlusDelta);
      if (!tokenHasExpired) {
        YLog.d(
            "Y-Auth: GetAccessTokenUseCase:: Token is still valid ${tokenModel}");
        onComplete(tokenModel);
        return;
      } else {
        YLog.d("Y-Auth: GetAccessTokenUseCase: Access Token has expired");
      }
    } else {
      YLog.d(
          "Y-Auth: GetAccessTokenUseCase: First Launch or Access Token has been force to update");
    }

    String refreshToken = await _preferencesDatasource.getRefreshToken();

    if (refreshToken.isNotEmpty) {
      AuthResponse authResponse =
          await _requestAccessTokenUseCase.execute(refreshToken);
      switch (authResponse) {
        case ErrorResponse():
          int statusCode = authResponse.statusCode;
          if (statusCode == 401) {
            _signOutUseCase.execute();
            onErrorRefreshTokenExpired("Refresh Token has expired");
            return;
          }
          break;

        case SuccessResponse():
          try {
            tokenModel = TokenModel.fromJson(json.decode(authResponse.body));
          } catch (e) {
            YLog.d("GetNewAccessToken: Token Model exception: ${e}");
          }
          break;
      }
    } else {
      onErrorRefreshTokenExpired("No Refresh token found");
      return;
    }

    onComplete(tokenModel);
  }
}
