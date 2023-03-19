import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Dio api = Dio();
  String? accessToken;
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  ApiProvider(String baseUrl) {
    api.options.baseUrl = baseUrl;
  }

  Future<dynamic> post(
      {required String url,
        Map<String, dynamic>? headers,
        String? contentType,
        Map<String, dynamic>? data,
        CancelToken? cancelToken}) async {
    try {
      final response = await api.post(url,
          options: Options(headers: headers, contentType: contentType),
          data: data,
          cancelToken: cancelToken);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 201:
          return response.data;
      }
    } on DioError catch (err) {
        print(err.toString());
      }
    }
}