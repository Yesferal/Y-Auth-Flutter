/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

abstract class PreferencesDatasource {
  Future<String> getRefreshToken();
  void saveRefreshToken(String token);
  Future<String> getAccessToken();
  void saveAccessToken(String token);
}
