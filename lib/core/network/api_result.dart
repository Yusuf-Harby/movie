sealed class ApiResult<T> {}

class ApiSuccess<T> extends ApiResult<T> {
  final T? data;
  ApiSuccess(this.data);
}

class ApiError<T> extends ApiResult<T> {
  final String error;
  ApiError(this.error);
}
