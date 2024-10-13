/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/model/auth_response_model.dart';

abstract class RemoteStorageDatasource {
  Future<AuthResponse> getAuthCodeFromApi(String appColor, String appName, String email);
  Future<AuthResponse> getRefreshTokenFromApi(String appPackageName, String authCode, String deviceId, String email);
}
