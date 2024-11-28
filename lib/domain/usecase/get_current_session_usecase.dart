/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:y_auth/domain/abstract/preferences_datasource.dart';
import 'package:y_auth/domain/model/session_model.dart';
import 'package:y_auth/framework/logger/y_log.dart';

class GetCurrentSessionUseCase {
  PreferencesDatasource _preferencesDatasource;

  GetCurrentSessionUseCase(this._preferencesDatasource);

  Future<SessionModel?> execute() async {
    String session = await _preferencesDatasource.getSession();
    YLog.d("GetCurrentSessionUseCase: Session: ${session}");
    try {
      if (session.isNotEmpty) {
        return SessionModel.fromJson(json.decode(session));
      }
    } catch (e) {
      YLog.d("GetCurrentSessionUseCase: Exception: ${e}");
    }

    return null;
  }
}
