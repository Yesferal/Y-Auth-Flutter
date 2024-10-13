/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/abstract/auth_remote_storage_datasource.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';

class RequestTokenUseCase {
  RemoteStorageDatasource remoteStorageDatasource;

  RequestTokenUseCase(this.remoteStorageDatasource);

  Future<AuthResponse> execute(String appPackageName, String authCode, String deviceId, String email) async {
    if (authCode.isEmpty) {
      return ErrorResponse("Invalid code", "Please enter a code");
    }

    return await this.remoteStorageDatasource.getRefreshTokenFromApi(appPackageName, authCode, deviceId, email);
  }
}
