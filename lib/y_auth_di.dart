/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:flutter/cupertino.dart';
import 'package:y_auth/domain/abstract/auth_environment.dart';
import 'package:y_auth/domain/abstract/auth_remote_storage_datasource.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/usecase/get_access_token_usecase.dart';
import 'package:y_auth/domain/usecase/get_current_session_usecase.dart';
import 'package:y_auth/domain/usecase/request_access_token_usecase.dart';
import 'package:y_auth/domain/usecase/sign_out_usecase.dart';
import 'package:y_auth/domain/usecase/cache_api_response_usecase.dart';
import 'package:y_auth/framework/http/auth_http_datasource.dart';
import 'package:y_auth/framework/preferences/shared_preferences_datasource.dart';
import 'package:y_auth/presentation/widget/request_auth_code_widget.dart';

class YAuthDi {
  final AuthEnvironment _authEnvironment;

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

  CacheApiResponseUseCase _getCacheApiResponseUseCase() {
    return CacheApiResponseUseCase();
  }

  GetAccessTokenUseCase getAccessTokenUseCase() {
    return GetAccessTokenUseCase(
        _getPreferencesDatasource(),
        _getRequestAccessTokenUseCase(),
        getSignOutUseCase(),
        _getCacheApiResponseUseCase());
  }

  Widget getRequestAuthCodeScreen(
      String color, String appName, String package) {
    return RequestAuthCodeScreen(_authEnvironment, color, appName, package);
  }

  SignOutUseCase getSignOutUseCase() {
    return SignOutUseCase(
        _getPreferencesDatasource(), _getCacheApiResponseUseCase());
  }

  GetCurrentSessionUseCase getCurrentSessionUseCase() {
    return GetCurrentSessionUseCase(_getPreferencesDatasource());
  }
}
