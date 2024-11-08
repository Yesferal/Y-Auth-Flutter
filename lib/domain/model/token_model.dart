/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

class TokenModel {
  String? message;
  ExpressToken? expressToken;

  TokenModel.fromJson(Map? json)
      : message = json?['message'],
        expressToken = ExpressToken.fromJson(json?['expressToken']);

  Map toJson() {
    return {
      'message': message,
      'expressToken': expressToken?.toJson()
    };
  }
}

class ExpressToken {
  String? refreshToken;
  String? accessToken;
  int? expiredIn;

  ExpressToken.fromJson(Map? json)
      : refreshToken = json?['refreshToken'],
        expiredIn = json?['expiredIn'],
        accessToken = json?['accessToken'];

  Map toJson() {
    return {
      'refreshToken': refreshToken,
      'expiredIn': expiredIn,
      'accessToken': accessToken
    };
  }
}
