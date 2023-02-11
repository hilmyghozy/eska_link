import 'package:dio/dio.dart';
import 'dart:developer';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("from api Intercaptor>> ${response.statusCode}");
    handler.next(response);
  }
}
