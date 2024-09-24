/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:flutter/material.dart';
import 'package:y_auth/framework/http/auth_api_routes.dart';
import 'package:y_auth/framework/http/auth_environment.dart';
import 'package:y_auth/framework/http/http_helper_third_party.dart';

class HttpDataSource {
  AuthEnvironment authEnvironment;

  HttpDataSource(this.authEnvironment);

  Future<String?> getAuthCodeFromApi(String appColor, String appName, String email) {
    final query = {
      'appColor': appColor,
      'appName': appName,
      'email': email
    };

    return _getResponse(AuthApiRoutes.GET_AUTH_CODE, query);
  }

  Future<String?> getRefreshTokenFromApi(String appPackageName, String authCode, String deviceId, String email,) {
    final query = {
      'appPackageName': appPackageName,
      'authCode': authCode,
      'deviceId': deviceId,
      'email': email
    };

    return _getResponse(AuthApiRoutes.GET_REFRESH_TOKEN, query);
  }

  Future<String?> _getResponse(String path, Map<String, dynamic> query) async {
    try {
      final String? response = await HttpHelperBuilder()
          .withHost(authEnvironment.authApiHost())
          .withPath(path)
          .withQuery(query)
          .withHeaders(authEnvironment.authHeaders())
          .build()
          .request();

      return response;
    } on Exception {
      debugPrint("Bad response format");
    }

    return null;
  }
}
