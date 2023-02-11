import 'dart:developer';

enum ResponseStatus { success, error, unreachable }

const String defaultError = 'Unknown error';

class BaseResult<T> {
  final ResponseStatus status;
  final T? data;
  final String errorMessage;
  final T? errData;

  BaseResult(this.status, this.data,
      {this.errorMessage = defaultError, this.errData});

  static BaseResult<T> success<T>(T data) =>
      BaseResult(ResponseStatus.success, data);

  static BaseResult<T> failed<T>(
      {int? code = -1, T? error, String? message, T? data}) {
    switch (code) {
      case 400:
        return BaseResult(
          ResponseStatus.error,
          data,
        );
      case 401:
        return BaseResult(
          ResponseStatus.error,
          data,
        );
      default:
        return BaseResult(
          ResponseStatus.error,
          error,
          errorMessage: message ?? defaultError,
        );
    }
  }

  static BaseResult<T> timeout<T>(String? message) => BaseResult(
        ResponseStatus.unreachable,
        null,
        errorMessage: message ?? defaultError,
      );
}

enum ResultStatus { init, loaded, failed }
