import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:eska_link/network/api_endpoints.dart';

import 'api_interceptor.dart';

class DioModule with DioMixin implements Dio {
  DioModule._() {
    options = BaseOptions(
      contentType: 'application/json',
      connectTimeout: 10 * 1000,
      sendTimeout: 10 * 1000,
      receiveTimeout: 10 * 1000,
      followRedirects: true,
      receiveDataWhenStatusError: true,
      baseUrl: Endpoint.baseUrl,
    );

    interceptors
      ..add(ApiInterceptor())
      ..add(LogInterceptor());

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => DioModule._();
}
