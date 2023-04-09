import 'package:dio/dio.dart';
import 'package:lettutor/data/services/api_exception.dart';

class ApiService {
  Dio api = Dio();
  String? accessToken;
  String baseUrl;

  ApiService(this.baseUrl);

  Future<dynamic> post(
      {required String url,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? data,
        CancelToken? cancelToken,
        Function()? onFailedAuthentication}) async {
    try {
      final response = await api.post("$baseUrl$url",
          options: Options(headers: headers, contentType: Headers.jsonContentType, method: 'POST'),
          data: data,
          cancelToken: cancelToken);
      switch(response.statusCode) {
        case 200:
          return response.data;
        case 201:
          return response.data;
        case 401:
          {
            onFailedAuthentication?.call();
            throw UnauthorizedException(response.statusMessage);
          }
        case 419:
          {
            onFailedAuthentication?.call();
            throw AccessTokenExpiredException(response.statusMessage);
          }
        case 500:
          throw FailedException(response.statusMessage);
      }
    } on DioError catch(err) {
      switch(err.type) {
        case DioErrorType.cancel:
          throw FailedException("Request is cancelled");
        default:
          throw FailedException("Failed");
      }
    }
  }

  Future<dynamic> get(
      {required String url,
        Map<String, dynamic>? headers,
        CancelToken? cancelToken,
        Function()? onFailedAuthentication }) async {
    try {
      final response = await api.get("$baseUrl$url",
          options: Options(headers: headers,  contentType: Headers.jsonContentType),
          cancelToken: cancelToken);
      switch(response.statusCode) {
        case 200:
          return response.data;
        case 201:
          return response.data;
        case 401:
          {
            onFailedAuthentication?.call();
            throw UnauthorizedException(response.statusMessage);
          }
        case 419:
          {
            onFailedAuthentication?.call();
            throw AccessTokenExpiredException(response.statusMessage);
          }
        case 500:
          throw FailedException(response.statusMessage);
      }
    } on DioError catch(err) {
      switch(err.type) {
        case DioErrorType.cancel:
          throw FailedException("Request is cancelled");
        default:
          throw FailedException("Failed");
      }
    }
  }


  Future<dynamic> postFormData(
      {required String url,
        Map<String, dynamic>? headers,
        required FormData data,
        CancelToken? cancelToken,
        Function()? onFailedAuthentication}) async {
    try {
      final response = await api.post("$baseUrl$url", options: Options(headers: headers, contentType: Headers.formUrlEncodedContentType), data: data, cancelToken: cancelToken);
      switch(response.statusCode) {
        case 200:
          return response.data;
        case 201:
          return response.data;
        case 401:
          {
            onFailedAuthentication?.call();
            throw UnauthorizedException(response.statusMessage);
          }
        case 419:
          {
            onFailedAuthentication?.call();
            throw AccessTokenExpiredException(response.statusMessage);
          }
        case 500:
          throw FailedException(response.statusMessage);
      }
    } on DioError catch(err) {
      switch(err.type) {
        case DioErrorType.cancel:
          throw FailedException("Request is cancelled");
        default:
          throw FailedException("Failed");
      }
    }
  }

}