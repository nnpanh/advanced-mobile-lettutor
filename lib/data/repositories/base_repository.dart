import 'package:dio/dio.dart';
import 'package:lettutor/data/services/api_service.dart';

abstract class BaseRepository {
  late CancelToken cancelToken;
  late ApiService service;

  BaseRepository(String prefix) {
    String apiBaseUrl = "https://sandbox.api.lettutor.com/";

    service = ApiService("$apiBaseUrl$prefix");
    cancelToken = CancelToken();
  }
}
