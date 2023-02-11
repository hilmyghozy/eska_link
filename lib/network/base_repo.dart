import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eska_link/network/base_result_error.dart';
import 'base_result.dart';
import 'dio_module.dart';
import 'dart:developer';

class BaseRepo {
  static Dio get _dio => DioModule.getInstance();

  static Future<BaseResult<T>> callApi<T>(Future<Response<T>> call) async {
    late Response? response;
    try {
      response = await call;

      if ((response.statusCode ?? 0) == 200) {
        return BaseResult.success(response.data);
      } else {
        return BaseResult.failed(message: response.data['detail'].toString());
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        // network errors
        return BaseResult.timeout("Network Failure");
      } else {
        // response error
        try {
          BaseRespError error = BaseRespError.fromJson(e.response?.data);
          return BaseResult.failed(
            code: e.response?.statusCode,
            data: e.response?.data,
            message: error.detail ??
                error.error?.message ??
                error.msg ??
                'Invalid response',
          );
        } catch (er) {
          log('error base2');
          return BaseResult.failed(
              message: e.response?.data?.toString() ??
                  "Unknown Error. ${er.toString()}");
        }
      }
    }
  }

  Future<BaseResult<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await callApi(
      _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  Future<BaseResult<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async =>
      await callApi(
        _dio.post(
          endpoint,
          data: body,
          options: Options(headers: headers),
        ),
      );

  Future<BaseResult<T>> delete<T>(String endpoint,
          {Map<String, dynamic>? headers, dynamic body}) async =>
      await callApi(
        _dio.delete(
          endpoint,
          options: Options(headers: headers),
          data: body,
        ),
      );

  Future<BaseResult<T>> put<T>(String endpoint,
          {Map<String, dynamic>? headers, dynamic body}) async =>
      await callApi(
        _dio.put(
          endpoint,
          data: body,
          options: Options(headers: headers),
        ),
      );

  Future<BaseResult<T>> postMultipart<T>(
    String endpoint, {
    Map<String, String>? headers,
    FormData? body,
  }) async =>
      await callApi(
        _dio.post(
          endpoint,
          data: body,
          options: Options(headers: headers),
        ),
      );
}
