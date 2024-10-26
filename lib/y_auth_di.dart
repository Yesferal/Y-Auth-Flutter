/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:flutter/cupertino.dart';
import 'package:y_auth/domain/abstract/auth_environment.dart';
import 'package:y_auth/domain/abstract/auth_remote_storage_datasource.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/usecase/get_access_token_usecase.dart';
import 'package:y_auth/domain/usecase/request_access_token_usecase.dart';
import 'package:y_auth/framework/http/auth_http_datasource.dart';
import 'package:y_auth/framework/preferences/shared_preferences_datasource.dart';
import 'package:y_auth/presentation/widget/request_auth_code_widget.dart';

class YAuthDi {
  AuthEnvironment _authEnvironment;

  YAuthDi(this._authEnvironment);

  PreferencesDatasource _getPreferencesDatasource() {
    return SharedPreferenceDataSource();
  }

  RemoteStorageDatasource _getRemoteStorageDatasource() {
    return HttpDataSource(_authEnvironment);
  }

  RequestAccessTokenUseCase _getRequestAccessTokenUseCase() {
    return RequestAccessTokenUseCase(_getRemoteStorageDatasource());
  }

  GetAccessTokenUseCase getAccessToken() {
    return GetAccessTokenUseCase(_getPreferencesDatasource(), _getRequestAccessTokenUseCase());
  }

  Widget getRequestAuthCodeScreen(String color, String appName, String package) {
    return RequestAuthCodeScreen(_authEnvironment, color, appName, package);
  }
}
