/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:convert';
import 'package:http/http.dart';
import 'package:y_auth/domain/abstract/auth_remote_storage_datasource.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';
import 'package:y_auth/domain/model/token_model.dart';
import 'package:y_auth/framework/http/auth_api_routes.dart';
import 'package:y_auth/domain/abstract/auth_environment.dart';
import 'package:y_auth/framework/logger/y_log.dart';

class HttpDataSource extends RemoteStorageDatasource {
  AuthEnvironment authEnvironment;

  HttpDataSource(this.authEnvironment);

  @override
  Future<AuthResponse> getAuthCodeFromApi(String appColor, String appName, String email) {
    final query = {
      'appColor': appColor,
      'appName': appName,
      'email': email
    };

    return _getResponse(AuthApiRoutes.GET_AUTH_CODE, query);
  }

  @override
  Future<AuthResponse> getRefreshTokenFromApi(String appPackageName, String authCode, String deviceId, String email,) {
    final query = {
      'appPackageName': appPackageName,
      'authCode': authCode,
      'deviceId': deviceId,
      'email': email
    };

    return _getResponse(AuthApiRoutes.GET_REFRESH_TOKEN, query);
  }

  @override
  Future<AuthResponse> getAccessTokenFromApi(String refreshToken) {
    final query = {
      'refreshToken': refreshToken
    };

    return _getResponse(AuthApiRoutes.GET_ACCESS_TOKEN, query);
  }

  Future<AuthResponse> _getResponse(String path, Map<String, dynamic> query) async {
    Uri uri = Uri.https(authEnvironment.authApiHost(), path, query);
    YLog.d("Uri: ${uri.toString()}");
    try {
      Response? response = await get(uri, headers: authEnvironment.authHeaders());

      /// TODO: Handle HTTP error code
      if (response.statusCode != 200) {
        ApiResponseModel apiResponseModel = ApiResponseModel.fromJson(json.decode(response.body));
        var errorMessage = "Get Uri Exception: (${response.statusCode}) ${apiResponseModel.messages?.infoMessage ?? ""}. Uri: ${uri.toString()}";
        YLog.d(errorMessage);
        return ErrorResponse(response.statusCode, errorMessage, apiResponseModel.messages?.displayMessage ?? "");
      }
      return SuccessResponse(response.body);
    } catch (e) {
      var errorMessage = "Get Uri Exception($e) : ${uri.toString()}";
      YLog.d(errorMessage);
      return ErrorResponse(400, errorMessage, "Please try again");
    }
  }
}
