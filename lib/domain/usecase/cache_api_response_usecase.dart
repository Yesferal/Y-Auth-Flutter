/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:y_auth/domain/model/token_model.dart';

class CacheApiResponseUseCase {
  factory CacheApiResponseUseCase() {
    return _singleton;
  }

  CacheApiResponseUseCase._internal();

  static final CacheApiResponseUseCase _singleton =
  CacheApiResponseUseCase._internal();

  ApiResponseModel? _apiResponseModel;

  void update(ApiResponseModel? apiResponseModel) async {
    this._apiResponseModel = apiResponseModel;
  }

  ApiResponseModel? getApiResponseModel() {
    return _apiResponseModel;
  }
}
