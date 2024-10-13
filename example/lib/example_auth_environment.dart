/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:y_auth/domain/abstract/auth_environment.dart';

class ExampleAuthEnvironment extends AuthEnvironment {

  ExampleAuthEnvironment() : super();

  init() async {
    await dotenv.load(fileName: ".env");
  }

  @override
  String authApiHost() {
    return dotenv.env['HOST'] ?? "";
  }

  @override
  Map<String, String> authHeaders() {
    return {dotenv.env['HEADER_KEY'] ?? "key": dotenv.env['HEADER_VALUE'] ?? "value" };
  }
}
