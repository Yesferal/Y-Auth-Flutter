/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

class MessageModel {
  String? message;

  MessageModel.fromJson(Map? json)
      : message = json?['message'];

  Map toJson() {
    return {'message': message};
  }
}
