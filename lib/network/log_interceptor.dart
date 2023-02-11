import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LogInterceptor extends Interceptor {
  final JsonEncoder encoder = const JsonEncoder();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      log("onRequest--> [${options.method.toUpperCase()}] ${options.uri}",
          name: 'api');

      if (options.headers.isNotEmpty) {
        log("Headers:", name: 'api');
        options.headers.forEach((k, v) => log('$k: $v', name: 'api'));
      }

      if (options.queryParameters.isNotEmpty) {
        log("queryParameters:", name: 'api');
        options.queryParameters.forEach((k, v) => log('$k: $v', name: 'api'));
      }

      log("Body: ${encoder.convert(options.data)}", name: 'api');
    } catch (e, stack) {
      log("Failed to log request.", name: 'api', error: e, stackTrace: stack);
    } finally {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      log("onResponse<-- [${response.statusCode}] ${response.realUri}",
          name: 'api');

      if (!response.headers.isEmpty) {
        log("Headers:", name: 'api');
        response.headers.forEach((k, v) => log('$k: $v', name: 'api'));
      }

      log("Response: ${encoder.convert(response.data)}", name: 'api');
      log("<-- END HTTP", name: 'api');
    } catch (e) {
      log("Failed to log response. $e", name: 'api');
    } finally {
      handler.next(response);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    try {
      log("<-- ${err.message} ${err.response?.realUri}", name: 'api');

      try {
        log(encoder.convert(err.response?.data), name: 'api');
      } catch (_) {
        log('undefined error', name: 'api');
      }
      log("<-- End error", name: 'api');
    } catch (e) {
      log("Failed to log error. $e", name: 'api');
    } finally {
      handler.next(err);
    }
  }
}
