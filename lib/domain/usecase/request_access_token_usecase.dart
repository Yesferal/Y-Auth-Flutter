/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/abstract/auth_remote_storage_datasource.dart';
import 'package:y_auth/domain/model/auth_response_model.dart';

class RequestAccessTokenUseCase {
  RemoteStorageDatasource _remoteStorageDatasource;

  RequestAccessTokenUseCase(this._remoteStorageDatasource);

  Future<AuthResponse> execute(String refreshToken) async {
    if (refreshToken.isEmpty) {
      return ErrorResponse(400, "Invalid refresh Token", "Please enter a code");
    }

    var authResponse = await _remoteStorageDatasource.getAccessTokenFromApi(refreshToken);

    return authResponse;
  }
}
