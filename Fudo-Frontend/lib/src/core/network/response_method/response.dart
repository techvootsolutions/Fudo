import 'package:fudo/src/core/utils/constants/app_const_functions.dart';

class Response<T> {
  final T? data;
  int? responseCode;
  final String? errorMessage;
  final bool success;

  Response.success(this.data) : errorMessage = null, success = true;

  Response.failure(this.errorMessage, {this.responseCode})
    : data = null,
      success = false;

  bool isSuccessWithData() {
    return success && data != null;
  }

  void handleResponse({
    required Function(T data) onSuccess,
    required Function(String errorMessage) onFailure,
  }) {
    if (isSuccessWithData()) {
      onSuccess(data as T);
    } else {
      logV("error====>${(errorMessage ?? "An error occurred")}");
      onFailure(errorMessage ?? "An error occurred");
    }
  }
}
