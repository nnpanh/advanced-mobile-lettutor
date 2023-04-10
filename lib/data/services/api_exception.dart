// class APIException implements Exception {
//   final String? _message;
//   final String? _prefix;
//
//   APIException([this._message, this._prefix]);
//
//   @override
//   String toString() {
//     return "$_prefix$_message";
//   }
// }
//
// class NoHaveDataException extends APIException {
//   NoHaveDataException([message]) : super(message, "");
// }
//
// class ServerError extends APIException {
//   ServerError([message]) : super(message, "Failed: ");
// }
//
// class UnauthorizedException extends APIException {
//   UnauthorizedException([message])
//       : super(message, "Unauthorized: Access token denied");
// }
//
// class AccessTokenExpiredException extends APIException {
//   AccessTokenExpiredException([message])
//       : super(message, "Access token expired: ");
// }
//
// class FailedException extends APIException {
//   FailedException([message]) : super(message, "Failed: ");
// }
