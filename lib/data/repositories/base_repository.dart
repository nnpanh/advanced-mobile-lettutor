import 'package:dio/dio.dart';
import 'package:lettutor/data/services/api_provider.dart';

abstract class BaseRepository {
  late CancelToken cancelToken;
  late ApiProvider provider;

  BaseRepository(String prefix) {
    String apiBaseUrl = "https://www.google.com/";

    provider = ApiProvider("$apiBaseUrl$prefix");
    cancelToken = CancelToken();
  }
}
