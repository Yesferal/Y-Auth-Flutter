/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/abstract/preferences_datasource.dart';

class SignOutUseCase {
  PreferencesDatasource _preferencesDatasource;

  SignOutUseCase(this._preferencesDatasource);

  void execute() async {
    _preferencesDatasource.saveRefreshToken("");
    _preferencesDatasource.saveAccessToken("");
  }
}
