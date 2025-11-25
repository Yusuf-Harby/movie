sealed class ApiResult<t> {}

class ApiSuccess<t> extends ApiResult<t> {
  final t? data;
  ApiSuccess(this.data);
}

class ApiError<t> extends ApiResult<t> {
  final String error;
  ApiError(this.error);
}
