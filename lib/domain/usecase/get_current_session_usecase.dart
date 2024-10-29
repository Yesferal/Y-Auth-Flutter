/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/model/session_model.dart';

class GetCurrentSessionUseCase {
  PreferencesDatasource _preferencesDatasource;

  GetCurrentSessionUseCase(this._preferencesDatasource);

  Future<SessionModel?> execute() async {
    String session = await _preferencesDatasource.getSession();
    debugPrint("GetCurrentSessionUseCase: Session: ${session}");
    try {
      if (session.isNotEmpty) {
        return SessionModel.fromJson(json.decode(session));
      }
    } catch (e) {
      debugPrint("GetCurrentSessionUseCase: Exception: ${e}");
    }

    return null;
  }
}
