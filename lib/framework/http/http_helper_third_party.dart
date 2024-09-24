/* Copyright © 2024 Yesferal Cueva. All rights reserved. */
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class HttpHelper {
  String path;
  String host;
  Map<String, dynamic> query;
  Map<String, String> headers;

  HttpHelper._(this.host, this.path, this.query, this.headers);

  Future<String?> request() async {
    Uri uri = Uri.https(host, path, query);
    debugPrint("Uri: ${uri.toString()}");
    try {
      Response? response = await get(uri, headers: headers);
      if (response.statusCode != 200) {
        throw HttpException(
            'There is a Response error: ${response.statusCode}');
      }
      return response.body;
    } catch (e) {
      debugPrint("Get Uri Exception: ${uri.toString()}");
      return Future.value(null);
    }
  }
}

class HttpHelperBuilder {
  String path = "";
  String host = "";
  Map<String, dynamic> query = {};
  Map<String, String> headers = {};

  HttpHelperBuilder withHost(String host) {
    this.host = host;

    return this;
  }

  HttpHelperBuilder withPath(String path) {
    this.path = path;

    return this;
  }

  HttpHelperBuilder withQuery(Map<String, dynamic> query) {
    this.query = query;

    return this;
  }

  HttpHelperBuilder withHeaders(Map<String, String> headers) {
    this.headers = headers;

    return this;
  }

  HttpHelper build() {
    return HttpHelper._(host, path, query, headers);
  }
}
