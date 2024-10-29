/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

sealed class AuthResponse {}

class SuccessResponse<T> extends AuthResponse {
  final T body;

  SuccessResponse(this.body);
}

class ErrorResponse extends AuthResponse {
  final int statusCode;
  final String message;
  final String displayMessage;

  ErrorResponse(this.statusCode, this.message, this.displayMessage);
}
