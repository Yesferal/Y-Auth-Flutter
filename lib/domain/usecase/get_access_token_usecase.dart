/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/model/token_model.dart';
import 'package:y_auth/domain/usecase/request_access_token_usecase.dart';

class GetAccessTokenUseCase {
  PreferencesDatasource _preferencesDatasource;
  RequestAccessTokenUseCase _requestAccessTokenUseCase;

  GetAccessTokenUseCase(
      this._preferencesDatasource, this._requestAccessTokenUseCase);

  void execute(Function(TokenModel? tokenModel) onComplete,
      Function(String) onErrorRefreshTokenExpired) async {
    /// TODO: Validate expiration before request
    /// to improve efficiency
    /// if (isNotExpire) return current-local-storage value
    TokenModel? tokenModel;
    String refreshToken = await _preferencesDatasource.getRefreshToken();

    if (refreshToken.isNotEmpty) {
      AuthResponse authResponse =
          await _requestAccessTokenUseCase.execute(refreshToken);
      switch (authResponse) {
        case ErrorResponse():

          /// TODO: Check http error code
          /// If refresh token was removed from server, then the user has to be logged out.
          if (false /*CODE == 401*/) {
            _preferencesDatasource.saveRefreshToken("");
            onErrorRefreshTokenExpired("Refresh Token has expired");
            return;
          }
          break;

        case SuccessResponse():
          try {
            tokenModel = TokenModel.fromJson(json.decode(authResponse.body));
          } catch (e) {
            debugPrint("GetNewAccessToken: Token Model exception: ${e}");
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
