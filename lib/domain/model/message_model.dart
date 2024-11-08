/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

class MessageModel {
  String? message;
  String? displayMessage;

  MessageModel.fromJson(Map? json)
      : message = json?['message'],
        displayMessage = json?['displayMessage'];

  Map toJson() {
    return {'message': message, 'displayMessage': displayMessage};
  }
}
