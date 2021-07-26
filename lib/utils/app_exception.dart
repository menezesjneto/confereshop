class AppException implements Exception {
  final _message;

  AppException([this._message]);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([String message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException([String message]) : super(message);
}

class ForbbidenException extends AppException {
  ForbbidenException([String message]) : super(message);
}

class InternalServerError extends AppException {
  InternalServerError([String message]) : super(message);
}

class DataBaseException extends AppException {
  DataBaseException([String message]) : super(message);
}