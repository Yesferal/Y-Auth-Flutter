/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

class SessionModel {
  String? email;
  String? displayName;

  SessionModel.fromJson(Map? json)
      : email = json?['email'],
        displayName = json?['displayName'];

  Map toJson() {
    return {'email': email, 'displayName': displayName};
  }
}
