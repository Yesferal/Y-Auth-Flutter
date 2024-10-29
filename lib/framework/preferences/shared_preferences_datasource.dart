/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';

class SharedPreferenceDataSource extends PreferencesDatasource {
  static const String GET_REFRESH_TOKEN_KEY = "get_refresh_token_key";
  static const String GET_ACCESS_TOKEN_KEY = "get_access_token_key";
  static const String GET_SESSION_KEY = "get_session_key";

  @override
  Future<String> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(GET_REFRESH_TOKEN_KEY) ?? "";
  }

  @override
  void saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(GET_REFRESH_TOKEN_KEY, token);
  }

  @override
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(GET_ACCESS_TOKEN_KEY) ?? "";
  }

  @override
  void saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(GET_ACCESS_TOKEN_KEY, token);
  }

  @override
  Future<String> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(GET_SESSION_KEY) ?? "";
  }

  @override
  void saveSession(String session) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(GET_SESSION_KEY, session);
  }
}
