/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/usecase/cache_api_response_usecase.dart';
import 'package:y_auth/framework/logger/y_log.dart';

class SignOutUseCase {
  PreferencesDatasource _preferencesDatasource;
  CacheApiResponseUseCase _cacheApiResponseUseCase;

  SignOutUseCase(this._preferencesDatasource, this._cacheApiResponseUseCase);

  void execute() async {
    YLog.d("SignOutUseCase: User Sign Out");
    _preferencesDatasource.saveRefreshToken("");
    _preferencesDatasource.saveAccessToken("");
    _preferencesDatasource.saveSession("");
    _cacheApiResponseUseCase.update(null);
  }
}
