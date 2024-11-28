/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

class MessageModel {
  String? infoMessage;
  String? displayMessage;

  MessageModel.fromJson(Map? json)
      : infoMessage = json?['infoMessage'],
        displayMessage = json?['displayMessage'];

  Map toJson() {
    return {'infoMessage': infoMessage, 'displayMessage': displayMessage};
  }
}
