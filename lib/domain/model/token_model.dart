/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

class TokenModel {
  String? refreshToken;
  String? accessToken;

  TokenModel.fromJson(Map? json)
      : refreshToken = json?['refreshToken'],
        accessToken = json?['accessToken'];

  Map toJson() {
    return {'refreshToken': refreshToken, 'accessToken': accessToken};
  }
}
