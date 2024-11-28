/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/model/message_model.dart';

class ApiResponseModel {
  MessageModel? messages;
  ExpressToken? expressToken;

  ApiResponseModel.fromJson(Map? json)
      : messages = MessageModel.fromJson(json?['messages']),
        expressToken = ExpressToken.fromJson(json?['expressToken']);

  Map toJson() {
    return {
      'messages': messages?.toJson(),
      'expressToken': expressToken?.toJson()
    };
  }
}

class ExpressToken {
  String? refreshToken;
  String? accessToken;
  int? expiredIn;
  int? requestedAt;

  ExpressToken.fromJson(Map? json)
      : refreshToken = json?['refreshToken'],
        expiredIn = json?['expiredIn'],
        accessToken = json?['accessToken'],
        requestedAt = DateTime.now().millisecondsSinceEpoch;

  Map toJson() {
    return {
      'refreshToken': refreshToken,
      'expiredIn': expiredIn,
      'accessToken': accessToken,
      'requestedAt': requestedAt
    };
  }
}
