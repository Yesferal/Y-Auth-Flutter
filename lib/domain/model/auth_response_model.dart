/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

sealed class AuthResponse {}

class SuccessResponse<T> extends AuthResponse {
  final T data;

  SuccessResponse(this.data);
}

class ErrorResponse extends AuthResponse {
  final String message;
  final String displayMessage;

  ErrorResponse(this.message, this.displayMessage);
}
